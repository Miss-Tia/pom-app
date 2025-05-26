# spec/requests/plantings_spec.rb

require 'rails_helper'

RSpec.describe "Plantings", type: :request do
  let!(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com") }
  let!(:garden) { Garden.first || Garden.create!(name: "Test Garden", location: "Backyard", user: user) }
  let!(:plant) { Plant.first || Plant.create!(name: "Tomato", variety: "Cherry", garden: garden) }

  describe "GET /plantings" do
    it "returns http success" do
      Planting.create!(
        garden: garden,
        plant: plant,
        date_planted: Date.today,
        season: "Spring",
        notes: "Test notes"
      )

      get plantings_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /plantings/:id" do
    it "returns http success" do
      planting = Planting.create!(
        garden: garden,
        plant: plant,
        date_planted: Date.today,
        season: "Spring",
        notes: "Test notes"
      )

      get planting_path(planting)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /plantings" do
    context "with valid parameters" do
      it "creates a new planting and redirects" do
        expect {
          post plantings_path, params: {
            planting: {
              plant_id: plant.id,
              garden_id: garden.id,
              date_planted: Date.today,
              season: "Spring",
              notes: "Planted during testing"
            }
          }
        }.to change(Planting, :count).by(1)

        expect(response).to redirect_to(assigns(:planting))
        follow_redirect!
        expect(response.body).to include("Planted during testing")
      end
    end

    context "with invalid parameters" do
      it "does not create a planting and re-renders the form" do
        post plantings_path, params: {
          planting: {
            plant_id: nil,
            garden_id: garden.id,
            date_planted: nil,
            season: "",
            notes: ""
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Date planted can&#39;t be blank").or include("can&#39;t be blank")
      end
    end
  end

  describe "PATCH /plantings/:id" do
    let!(:planting) {
      Planting.create!(
        plant: plant,
        garden: garden,
        date_planted: Date.today,
        season: "Spring",
        notes: "Original notes"
      )
    }

    context "with valid parameters" do
      it "updates the planting and redirects" do
        patch planting_path(planting), params: {
          planting: {
            notes: "Updated notes"
          }
        }

        expect(response).to redirect_to(planting_path(planting))
        follow_redirect!
        expect(response.body).to include("Updated notes")
      end
    end

    context "with invalid parameters" do
      it "does not update the planting and re-renders the edit form" do
        patch planting_path(planting), params: {
          planting: {
            date_planted: nil
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Date planted can&#39;t be blank").or include("can&#39;t be blank")
      end
    end
  end
end
