require 'test_helper'
require 'biblio'

describe Biblio do
  describe ".emprunter" do
    let(:a) { Emprunt.new(toto, toto@blob.com, 'Harry Potter', 'JK Rowling') }
    let(:b) { Emprunt.new(bob, bob@gmail.com, 'The Martian', 'Andy Weir') }

    before @emprunts = [a,b]
 
