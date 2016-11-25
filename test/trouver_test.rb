require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.trouver" do

    before do
      Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
    end

    describe "cas avec un extrait correspondant a plusieurs titres" do
      it "retourne les titres contenant l'extrait" do
        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir", "untel%untel@truc.com%Tout espoir%Auteur%true"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.trouver( "ar" ).must_equal( ["Harry Potter", "The Martian"] )
          end
        end
      end
    end
  end
end
