# -*- coding: utf-8 -*-
module Biblio

  UN_COURRIEL = /([\w\.]*@[\w\.]*)/

  #
  # Façade pour abstraire les opérations sur une "bibliothèque" associée à un fichier/dépôt.
  #
  class Biblio
    include Exceptions


    #################################################################
    # Methodes de classe.
    #################################################################

    # Registre des differentes instances actives.
    #
    @@les_biblios = {}

    # Obtient/crée l'objet Biblio approprié pour le fichier indiqué.
    # Pourrait déjà être instancié.
    #
    # Crée un nouveau dépôt si demandé (:creer), auquel cas soulève une erreur s'il existe déjà,
    # à moins que l'option appropriée (:detruire_si_existe) n'ait été spécifiée.
    #
    def self.ouvrir( fich_depot, opts = {:creer => false, :detruire_si_existe => false} )
      Debug.log( "Biblio.ouvrir( #{fich_depot}, #{opts} )" )

      if opts[:creer]
        # Demande de création: on crée le dépôt et on "oublie" ce qu'on avait déjà le cas échéant.
        Emprunts.creer_depot( fich_depot, :detruire_si_existe => opts[:detruire_si_existe] )
        @@les_biblios[fich_depot] = nil
      end

      fail ErreurDepotInexistant, "Le fichier \'#{fich_depot}\' n\'existe pas!?" unless FileTest.exists?(fich_depot)

      biblio = @@les_biblios[fich_depot]

      unless biblio
        biblio = Biblio.new( fich_depot )
        @@les_biblios[fich_depot] = biblio
      end

      biblio
    end

    # Pour fermeture automatique à la fin du programme.
    #
    at_exit do
      @@les_biblios.each_value do  |b|
        b.fermer
      end
    end


    #################################################################
    # Methodes d'instance.
    #################################################################

    def initialize( fich_depot )
      Debug.log( "Biblio#initialize( #{fich_depot} )" )

      @fich_depot = fich_depot
      @emprunts = nil      # Definie/chargee paresseusement.
      @transaction_debutee = false
    end

    # Méthode 'around' pour les cas où on veut effectuer plusieurs opérations sur la bibliothèque,
    # mais où on ne veut rien sauvegarder si l'une des opérations échoue.
    #
    def avec_transaction
      @transaction_debutee = true
      yield
      @transaction_debutee = false
    end


    # Les différents emprunts associés, chargés de façon
    # paresseuse, i.e., l'ouverture du dépôt ne se fait que lorsqu'on
    # tente d'accéder à ces emprunts.
    #
    def les_emprunts
      @emprunts ||= Emprunts.ouvrir( @fich_depot )

      @emprunts
    end


    # Ferme la biblio, en sauvegardant les emprunts associés si nécessaire.
    # À n'appeler que dans le cadre de tests, car autrement
    # la fermeture s'effectue automatiquement à la fin du programme.
    #
    def fermer
      # Pour les tests uniquement: autrement devrait se faire
      # automatiquement a la fin du programme: cf. plus bas.
      Debug.log( "Biblio#fermer" )

      @emprunts.fermer if @emprunts && ! @transaction_debutee
      @emprunts = nil
      @transaction_debutee = false
      @@les_biblios.delete( @fich_depot )
    end


    # Retourne les emprunts fait par l'emprunteur nom.
    #
    def emprunts_de( nom )
      Debug.log( "Biblio#emprunts_de( #{nom} )" )

      les_emprunts.
        selectionner { |e| e.nom == nom }.
        map{ |e| e.titre }.
        sort
    end

    # Retourne tous les emprunts.
    #
    def emprunts( opts = {:inclure_perdus => false} )
      Debug.log( "Biblio#emprunts( #{opts} )" )

      les_emprunts.
        selectionner { |e| if opts[:inclure_perdus] then true else !e.perdu? end }.
        sort
    end

    # Retourne l'emprunteur du titre indiqué.
    #
    def emprunteur( titre )
      Debug.log( "Biblio#emprunteur( #{titre} )" )

      # On ne peut pas utiliser (:unique => true) car il pourrait y en avoir aucun!
      es = les_emprunts.selectionner { |e| e.titre == titre }

      DBC.assert es.size <= 1, "Cas impossible: plusieurs fois le meme titre '#{titre}'"

      if es.size == 1
        es[0].nom
      else
        nil
      end
    end


    # Indique un emprunt.
    #
    def emprunter( nom, courriel, titre, auteurs )
      DBC.requires courriel =~ UN_COURRIEL, "Format invalide de courriel: #{courriel}!?"
      Debug.log( "Biblio#emprunter( #{nom}, #{courriel}, #{titre}, #{auteurs} )" )

      qui = emprunteur( titre )

      fail ErreurDejaEmprunte, qui if qui

      les_emprunts.ajouter( Emprunt.new( nom, courriel, titre, auteurs ) )
    end

    # Rapporte le titre indiqué, donc supprime l'emprunt associé (qui doit exister).
    #
    def rapporter( titre )
      Debug.log( "Biblio#rapporter( #{titre} )" )

      emps = les_emprunts.selectionner { |e| e.titre == titre }

      fail ErreurPasEmprunte, titre if emps.size == 0
      DBC.assert emps.size == 1, "Cas impossible: Plusieurs emprunts pour titre '#{titre}'"

      les_emprunts.supprimer( emps[0] )
    end

    # Signale la perte du titre indiqué -- mais garde l'emprunt associé actif, au cas ou...
    #
    def indiquer_perte( titre )
      Debug.log( "Biblio#indiquer_perte( #{titre} )" )

      emps = les_emprunts.selectionner { |e| e.titre == titre }

      fail ErreurPasEmprunte, titre if emps.size == 0
      DBC.assert emps.size == 1, "Cas impossible: Plusieurs emprunts pour titre '#{titre}'"

      les_emprunts.indiquer_perte( emps[0] )
    end


    # Trouve tous les emprunts dont le titre contient extrait_titre.
    #
    def trouver( extrait_titre )
      Debug.log( "Biblio#trouver( #{extrait_titre} )" )

      les_emprunts.
        selectionner { |e| e.titre =~ /#{extrait_titre}/ }.
        map { |e| e.titre }.
        sort
    end


    # Transmet un courriel de rappel à l'emprunteur du titre indiqué.
    #
    def rappeler_livre( titre )
      Debug.log( "Biblio#rappeler_livre( #{titre} )" )

      emp = les_emprunts.selectionner(:unique => true) { |e| e.titre == titre }

      fail ErreurPasEmprunte, titre unless emp

      emp.rappeler
      emp
    end


    # Transmet des courriels de rappel à tous les emprunteurs.
    #
    def rappeler_tous_les_livres
      Debug.log( "Biblio#rappeler_tous_les_livres" )

      transmis, errones = [], []
      emprunts.each do |emp|
        begin
          emp.rappeler
          transmis << emp
        rescue => e      # Implicitement StandardError
          Debug.log( "Biblio#rappeler_tous_les_livres: Exception #{e.class}: #{e.message} -- #{e.backtrace}" )
          errones << [ emp, e ]
        end
      end

      return transmis, errones
    end

  end

end

