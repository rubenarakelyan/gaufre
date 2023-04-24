require "rails_helper"

RSpec.describe "Pages" do
  describe "GET /_/external_gopher_link" do
    subject(:page) { get "/_/external_gopher_link?uri=example.com/0/test.txt" }

    it "returns a page with a link to the Gopher URI" do
      page
      expect(response.body).to include("gopher://example.com/0/test.txt")
    end
  end
end
