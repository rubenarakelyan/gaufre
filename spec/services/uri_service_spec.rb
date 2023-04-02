require "rails_helper"

RSpec.describe UriService do
  describe ".external_uri?" do
    before do
      allow(ENV).to receive(:fetch).with("GOPHER_HOST").and_return("fossil.wackomenace.co.uk")
      allow(ENV).to receive(:fetch).with("GOPHER_PORT", "70").and_return("70")
      allow(ENV).to receive(:fetch).with("GOPHER_PATH", "").and_return("")
    end

    context "when the URI is internal to the Gopher hole" do
      subject(:uri) do
        described_class.external_uri?(host: "fossil.wackomenace.co.uk", port: "70", selector: "/0/test.txt")
      end

      it "returns false" do
        expect(uri).to be false
      end
    end

    context "when the URI is on an external Gopher hole" do
      subject(:uri) { described_class.external_uri?(host: "example.com", port: "70", selector: "/0/test.txt") }

      it "returns true" do
        expect(uri).to be true
      end
    end
  end

  describe ".external_path?" do
    before do
      allow(ENV).to receive(:fetch).with("GOPHER_HOST").and_return("fossil.wackomenace.co.uk")
      allow(ENV).to receive(:fetch).with("GOPHER_PORT", "70").and_return("70")
      allow(ENV).to receive(:fetch).with("GOPHER_PATH", "").and_return("users/example/")
    end

    context "when the path is within the defined Gopher path root" do
      subject(:uri) { described_class.external_path?(path: "0/users/example/test.txt") }

      it "returns false" do
        expect(uri).to be false
      end
    end

    context "when the path is outside the defined Gopher path root" do
      subject(:uri) { described_class.external_path?(path: "0/users/example2/test.txt") }

      it "returns true" do
        expect(uri).to be true
      end
    end
  end
end
