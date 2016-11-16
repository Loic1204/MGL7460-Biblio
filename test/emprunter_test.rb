require 'test_helper'
require 'biblio'


describe Biblio::Biblio do
  describe ".emprunter" do
    let(:a) { Biblio::Emprunt.new('toto', 'toto@blob.com', 'Harry Potter', 'JK Rowling')}
    let(:b) { Biblio::Emprunt.new('bob','bob@gmail.com','The Martian','Andy Weir')}

    before do @emprunts = [:a,:b] end
 
    describe "cas avec une demande d emprunt d un livre disponible" do
      it "retourne la table avec l ajout du nouvel emprunt" do
        @new_emprunts = [a,b,Biblio::Emprunt.new('pif', 'pif@gmail.com', 'Les Miserables', 'Victor Hugo')]
        emprunter('pif','pif@gmail.com','Les Miserables','Victor Hugo')
          .must_equal @new_emprunts
      end
    end
  end
end

