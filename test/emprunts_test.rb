require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.emprunts" do

    before do
      Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
    end

    describe "cas avec la liste des emprunts d'une personne" do
      it "retourne les emprunts faits pas la personne" do
        @stdout = ""

        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir", "untel%untel@truc.com%Tout espoir%Auteur%true"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.emprunts_de("toto").join("\n").must_equal( "Harry Potter" )
          end
        end
      end
    end
  end
end
