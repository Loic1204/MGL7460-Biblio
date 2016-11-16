require 'test_helper'
require 'biblio'

describe Biblio do
  describe ".emprunter" do
    let(:a) { Emprunt.new(toto, toto@blob.com, 'Harry Potter', 'JK Rowling') }
    let(:b) { Emprunt.new(bob, bob@gmail.com, 'The Martian', 'Andy Weir') }

    before @emprunts = [a,b]
 
    describe "cas avec une demande d emprunt d un livre disponible" do
      it "retourne la table avec l ajout du nouvel emprunt" do
        @new_emprunts = [a,b,Emprunt.new(pif, pif@gmail.com, 'Les Miserables', 'Victor Hugo')]
        Biblio.emprunter(pif, pif@gmail.com, 'Les Miserables', 'Victor Hugo')
          .must_equal @new_emprunts
      end
    end
  end
end
