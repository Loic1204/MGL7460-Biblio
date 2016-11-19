require 'test_helper'
require 'biblio'

describe Biblio do
  describe "Biblio.rapporter" do
    #let(:a) { Biblio::Emprunt.new("toto", "toto@blob.com", "Harry Potter", ["JK Rowling"]) }
    #let(:b) { Biblio::Emprunt.new("bob", "bob@gmail.com", "The Martian", ["Andy Weir"]) }

    before do
      IO.stub :readlines, ["toto%toto@blob.com%Harry Potter%JK Rowling", "bob%bob@gmail.com%The Martian%Andy Weir"] do
        @emprunts_test = Biblio::Emprunts.new( "test" )
      end
      @biblio = Biblio::Biblio.new( "test" )
    end

    describe "cas avec un retour de document emprunte" do
      it "supprime l'emprunt" do
        @biblio.stub :les_emprunts, @emprunts_test do
          @biblio.rapporter("The Martian")
        end
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
