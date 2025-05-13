require 'rails_helper'

RSpec.describe "Plantings", type: :request do
  let(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com") }
  let(:garden) { Garden.first || Garden.create!(name: "Test Garden", location: "Backyard", user: user) }
  let(:plant) { Plant.first || Plant.create!(name: "Tomato", variety: "Cherry", garden: garden) }

  before do
    Planting.create!(
      garden: garden,
      plant: plant,
      date_planted: Date.today,
      season: "Spring",
      notes: "Test notes"
    )
  end

  describe "GET /plantings" do
    it "returns http success" do
      get plantings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /plantings/:id" do
    it "returns http success" do
      planting = Planting.first
      get planting_path(planting)
      expect(response).to have_http_status(:success)
    end
  end
end
