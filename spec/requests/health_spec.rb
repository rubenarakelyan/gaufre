require "rails_helper"

RSpec.describe "Health" do
  describe "GET /_/up" do
    it "return a 200 OK response" do
      get "/_/up"
      expect(response).to have_http_status(:ok)
    end
  end
end
