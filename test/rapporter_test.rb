require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.rapporter" do

    before do
      Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
    end

    describe "cas avec un retour de document emprunte" do
      it "supprime l'emprunt" do
        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.rapporter("The Martian")
          end
        end
      end
    end

    describe "cas avec un retour de document non emprunte" do
      it "ne modifie rien" do
        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.rapporter("The Martian 2: la revanche")
          end
        end
      end
    end
  end
end
