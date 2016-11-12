# -*- coding: utf-8 -*-
module Biblio

  # Les différentes exceptions pouvant être signalées
  #
  module Exceptions

    ErreurAucuneAdresseCourriel = Class.new( StandardError )

    ErreurDepotExisteDeja       = Class.new( StandardError )

    ErreurDepotInexistant       = Class.new( StandardError )

    ErreurDejaEmprunte          = Class.new( StandardError )

    ErreurFormatNonTraite       = Class.new( StandardError )

    ErreurPasEmprunte           = Class.new( StandardError )

    ErreurPasJusteUnEmprunt     = Class.new( StandardError )

  end
end

