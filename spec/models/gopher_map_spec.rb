require "rails_helper"

RSpec.describe GopherMap do
  describe ".to_a" do
    let(:subject) { GopherMap.new(rows:).to_a }

    context "when given a Gopher Map as an array" do
      let(:rows) { ["1Test file\tfiles/test.txt\tfossil.wackomenace.co.uk\t70"] }

      it "returns an array of GopherMapEntry objects" do
        expect(subject[0]).to be_a GopherMapEntry
        expect(subject[0].filetype).to eq("1")
        expect(subject[0].name).to eq("Test file")
        expect(subject[0].selector).to eq("files/test.txt")
        expect(subject[0].host).to eq("fossil.wackomenace.co.uk")
        expect(subject[0].port).to eq("70")
      end
    end
  end
end
