require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.rapporter" do
    let(:a) { Biblio::Emprunt.new("toto", "toto@blob.com", "Harry Potter", ["JK Rowling"]) }
    let(:b) { Biblio::Emprunt.new("bob", "bob@gmail.com", "The Martian", ["Andy Weir"]) }

    before do
      @emprunts = [a,b]
    end

    #besoin de créer un objet biblio avant d'utiliser les methodes
    describe "cas avec un retour de document emprunte" do
      it "supprime l'emprunt" do
        #Emprunts.stub :selectionner, @emprunts do
          Biblio::Biblio.rapporter("The Martian").must_equal( [a] )
        #end
      end
    end

    describe "cas avec un retour de document non emprunte" do
      it "ne modifie rien" do
        #Emprunts.stub :selectionner, @emprunts do
          Biblio::Biblio.rapporter("The Martian 2: la revanche").must_equal( @emprunts )
        #end
      end
    end
  end
end
