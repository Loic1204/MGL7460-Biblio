require 'fileutils'
require_relative 'assertions'
require 'biblio'

#####################################################
# Preconditions.
#####################################################

# Voir support/hooks.rb

Given(/^il n'existe pas de fichier "([^"]*)"$/) do |fichier|
  FileUtils.rm_f fichier
end

Given(/^il existe un fichier "([^"]*)"$/) do |fichier|
  FileUtils.touch fichier
end


#####################################################
# Actions/evenements.
#####################################################

When(/^j'ouvre les emprunts pour le depot "([^"]*)"$/) do |fichier|
  @emprunts_repository = Emprunts::Emprunts.ouvrir( fichier )
end

When(/^je selectionne les emprunts faits par "([^"]*)"$/) do |nom|
  @selection = @emprunts_repository.selectionner do |e|
    e.nom == nom
  end
end

When(/^je selectionne les emprunts dont le titre matche "([^"]*)"$/) do |patron|
  @selection = @emprunts_repository.selectionner do |e|
    e.titre =~ /#{patron}/
  end
end

When(/^je selectionne l'unique emprunt dont le titre est "([^"]*)"$/) do |titre|
  @selection = @emprunts_repository.selectionner( unique: true ) do |e|
    e.titre == titre
  end
end

When(/^je selectionne les emprunts tels que le "([^"]*)" matche "([^"]*)"$/) do |champ, patron|
end


When(/^je supprime l'emprunt selectionne$/) do
  @emprunts_repository.supprimer( @selection )
end




When(/^je retourne l'emprunteur de l'unique emprunt dont le titre matche "([^"]*)"$/) do |titre|
  @stdout = @biblio_repository.emprunteur( titre )
end

When(/^j'indique que l'emprunt "([^"]*)" est perdu$/) do |titre|
  @biblio_repository.indiquer_perte( titre )
end

When(/^je cree un depot sans nom$/) do
  Biblio::Biblio.ouvrir( Biblio::DEPOT_DEFAUT, {:creer => true, :detruire_si_existe => false} )
end

When(/^je cree un depot texte "([^"]*)"$/) do |depot|
  Biblio::Biblio.ouvrir( depot, {:creer => true, :detruire_si_existe => false} )
end

When(/^je cree un depot texte sans nom en indiquant de le detruire s'il existe$/) do
  Biblio::Biblio.ouvrir( Biblio::DEPOT_DEFAUT, {:creer => true, :detruire_si_existe => true} )
end

When(/^je cree un depot texte "([^"]*)" en indiquant de le detruire s'il existe$/) do |depot|
  Biblio::Biblio.ouvrir( depot, {:creer => true, :detruire_si_existe => true} )
end

When(/^je liste les emprunts qui ne sont pas perdus$/) do
  @stdout = ""
  @biblio_repository.emprunts( :inclure_perdus => false ).each do |emp|
    @stdout << ( emp.to_s('%-.20N :: [ %-10A ] "%-.20T"') )
    @stdout << "\n"
  end
  puts @stdout
end

When(/^je liste tous les emprunts$/) do
  @stdout = ""
  @biblio_repository.emprunts( :inclure_perdus => true ).each do |emp|
    perdu = emp.perdu? ? " <<PERDU>> " : ""
    @stdout << ( emp.to_s('%-.20N :: [ %-10A ] "%-.20T"') << perdu )
    @stdout << "\n"
  end
  puts @stdout
end

When(/^je rapporte un emprunt dont le titre est "([^"]*)"$/) do |titre|
  @biblio_repository.rapporter( titre )
end

When(/^je selectionne l'emprunt dont le titre matche "([^"]*)"$/) do |titre|
  @selection = @biblio_repository.les_emprunts.selectionner( unique: false ) do |e|
    e.titre == titre
  end
end

When(/^je trouve les emprunts dont le titre matche "([^"]*)"$/) do |extrait_titre|
  @selection = @biblio_repository.trouver( extrait_titre )
end

When(/^je selectionne les emprunts fait par "([^"]*)"$/) do |nom|
  @stdout = ""
  @stdout << @biblio_repository.emprunts_de(nom).join("\n")
end


#####################################################
# Postconditions.
#####################################################

Then(/^il n'y a aucun emprunt$/) do
  assert_equal @emprunts_repository.size, 0
end

Then(/^il y a (\d+) emprunts$/) do |nb|
  assert_equal @emprunts_repository.size, nb.to_i
end

Then(/^l'emprunteur de "([^"]*)" est "([^"]*)"$/) do |titre, nom|
  emp = @emprunts_repository.selectionner( unique: true ) do |e|
    e.titre == titre
  end
  assert_equal nom, emp.nom
end

Then(/^(\d+) document(?:s)? (?:a|ont) ete selectionne(?:s)?$/) do |nb|
  assert_equal nb.to_i, @selection.size
end

Then(/^le titre du document (\d+) est "([^"]*)"$/) do |nb, titre|
  assert_equal @selection[nb.to_i].titre, titre
end

Then(/^le titre de l'unique document selectionne est "([^"]*)"$/) do |titre|
  assert_equal @selection.titre, titre
end




Then(/^le nom retourne est "([^"]*)"$/) do |nom|
  assert_equal @stdout, nom
end

Then(/^aucun nom n'est retourne$/) do
  assert_equal @stdout, nil
end

Then(/^l'emprunt "([^"]*)" est considere comme etant perdu$/) do |titre|
  @selection = @biblio_repository.les_emprunts.selectionner( unique: true ) do |e|
    e.titre == titre
  end
  assert_equal @selection.perdu?, true
end

Then(/^le fichier "([^"]*)" existe$/) do |fichier|
  File.exist? fichier
end

Then(/^on retourne$/) do |string|
  assert_equal( @stdout, string)
end

Then(/^on retourne la table$/) do |table|

  ###
  # Pris de la page http://stackoverflow.com/questions/19909912/cucumber-reading-data-from-a-3-column-table
  ###
  data = table.transpose.raw.inject({}) do |hash, column| 
    column.reject!(&:empty?)
    hash[column.shift] = column
    hash    
  end

  assert_equal( @selection, data['titre'])
end

Then(/^(\d+) documents ont ete affiches$/) do |number|
  @tab = @stdout.split("\n")
  assert_equal( number.to_i, @tab.size )
end



