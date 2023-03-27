require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /_/external_gopher_link" do
    context "when requested" do
      let(:subject) { get "/_/external_gopher_link?uri=example.com/0/test.txt" }

      it "returns a page with a link to the Gopher URI" do
        subject
        expect(response.body).to include("gopher://example.com/0/test.txt")
      end
    end
  end
end
