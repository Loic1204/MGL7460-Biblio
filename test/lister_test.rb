require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.lister" do

    before do
      Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
    end

    describe "cas avec la liste des emprunts non-perdus" do
      it "retourne les deux emprunts non perdus" do
        @stdout = ""

        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir", "untel%untel@truc.com%Tout espoir%Auteur%true"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.emprunts( :inclure_perdus => false ).each do |emp|
              @stdout << ( emp.to_s('%-.20N :: [ %-10A ] "%-.20T"') ) << "\n"
            end
            @stdout.must_equal( 'bob :: [ Andy Weir  ] "The Martian"' << "\n" << 'toto :: [ JK Rowling ] "Harry Potter"' << "\n" )
          end
        end
      end
    end

    describe "cas avec la liste de tous les emprunts" do
      it "retourne tous les emprunts" do
        @stdout = ""

        FileTest.stub :exists?, true do
          IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir", "untel%untel@truc.com%Tout espoir%Auteur%true"] do
            @biblio = Biblio::Biblio.ouvrir( '.test.txt' )
            @biblio.emprunts( :inclure_perdus => true ).each do |emp|
              perdu = emp.perdu? ? " <<PERDU>> " : ""
              @stdout << ( emp.to_s('%-.20N :: [ %-10A ] "%-.20T"') << perdu << "\n" )
            end
            @stdout.must_equal( 'bob :: [ Andy Weir  ] "The Martian"' << "\n" 'toto :: [ JK Rowling ] "Harry Potter"' << "\n" 'untel :: [ Auteur     ] "Tout espoir" <<PERDU>> ' << "\n" )
          end
        end
      end
    end
  end
end
