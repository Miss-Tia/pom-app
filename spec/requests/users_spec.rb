require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Sign up") # Optional: check for a phrase on the page
    end
  end
end
