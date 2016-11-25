require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.emprunteur" do

    before do
      Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
    end

    describe "cas avec un emprunt inexistant" do
      it "ne retourne rien" do
        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.emprunteur( "Machin" ).must_equal( nil )
          end
        end
      end
    end

    describe "cas avec un emprunt existant" do
      it "retourne le nom de l'emprunteur" do
        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.emprunteur( "Harry Potter" ).must_equal( "toto" )
          end
        end
      end
    end
  end
end
