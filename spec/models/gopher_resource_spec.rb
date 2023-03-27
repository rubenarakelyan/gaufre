require "rails_helper"

RSpec.describe GopherResource do
  describe ".object" do
    let(:subject) { GopherResource.new(filetype:, selector:, response:).object }

    context "if the resource is a Gopher Map" do
      let(:filetype) { "1" }
      let(:selector) { "files" }
      let(:response) do
        "1Test file\tfiles/text.txt\tfossil.wackomenace.co.uk\t70"
      end

      it "returns a GopherMap object" do
        expect(subject).to be_a GopherMap
      end
    end

    context "if the resource is not a Gopher Map" do
      let(:filetype) { "0" }
      let(:selector) { "files/test.txt" }
      let(:response) do
        "This is a test file"
      end

      it "returns a GopherFile object" do
        expect(subject).to be_a GopherFile
      end
    end
  end
end
