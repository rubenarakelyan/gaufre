require "rails_helper"

RSpec.describe GopherMap do
  describe ".to_a" do
    subject(:gopher_map) { described_class.new(rows:).to_a }

    context "when given a Gopher Map as an array" do
      let(:rows) { ["1Test file\tfiles/test.txt\tfossil.wackomenace.co.uk\t70"] }

      # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations
      it "returns an array of GopherMapEntry objects" do
        expect(gopher_map[0]).to be_a GopherMapEntry
        expect(gopher_map[0].filetype).to eq("1")
        expect(gopher_map[0].name).to eq("Test file")
        expect(gopher_map[0].selector).to eq("files/test.txt")
        expect(gopher_map[0].host).to eq("fossil.wackomenace.co.uk")
        expect(gopher_map[0].port).to eq("70")
      end
      # rubocop:enable RSpec/ExampleLength, RSpec/MultipleExpectations
    end
  end
end
