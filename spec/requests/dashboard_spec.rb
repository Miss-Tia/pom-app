require 'rails_helper'

RSpec.describe "Dashboards", type: :request do
  let!(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com", password: "password", password_confirmation: "password") }

  before do
    post login_path, params: { email: user.email, password: "password" }
  end

  describe "GET /dashboards/:id" do
    it "returns http success" do
      get dashboard_path(user.id)
      expect(response).to have_http_status(:success)
    end
  end
end
