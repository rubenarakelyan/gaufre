require "rails_helper"

RSpec.describe GopherMapEntry do
  describe ".link" do
    context "when an entry is an information entry" do
      subject(:gopher_map_entry) do
        described_class.new(
          filetype: "i",
          name: "Here's some information",
          selector: "",
          host: "null.host",
          port: "1"
        ).link
      end

      it "returns an empty link" do
        expect(gopher_map_entry).to eq("")
      end
    end

    context "when an entry is an HTTP URL" do
      subject(:gopher_map_entry) do
        described_class.new(
          filetype: "h",
          name: "This is an external link",
          selector: "URL:http://www.example.com",
          host: "fossil.wackomenace.co.uk",
          port: "70"
        ).link
      end

      it "returns a URL" do
        expect(gopher_map_entry).to eq("http://www.example.com")
      end
    end

    context "when an entry is an external Gopher hole" do
      subject(:gopher_map_entry) do
        described_class.new(
          filetype: "1",
          name: "This is an external Gopher hole",
          selector: "/this/is/a/test",
          host: "example.com",
          port: "70"
        ).link
      end

      it "returns a link to the external link information page" do
        expect(gopher_map_entry).to eq("/_/external_gopher_link?uri=example.com:70/1/this/is/a/test")
      end
    end

    context "when an entry is an internal file" do
      subject(:gopher_map_entry) do
        described_class.new(
          filetype: "0",
          name: "This is a test file",
          selector: "/this/is/a/test.txt",
          host: "fossil.wackomenace.co.uk",
          port: "70"
        ).link
      end

      it "returns a link to the file" do
        expect(gopher_map_entry).to eq("/0/this/is/a/test.txt")
      end
    end
  end
end
