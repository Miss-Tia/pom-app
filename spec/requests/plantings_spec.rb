require 'rails_helper'

RSpec.describe "Plantings", type: :request do
<<<<<<< HEAD
  let(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com") }
  let(:garden) { Garden.first || Garden.create!(name: "Test Garden", location: "Backyard", user: user) }
  let(:plant) { Plant.first || Plant.create!(name: "Tomato", variety: "Cherry", garden: garden) }

  before do
    Planting.create!(
      garden: garden,
      plant: plant,
=======
  let!(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com", password: "password", password_confirmation: "password") }
  let!(:garden) { Garden.first || Garden.create!(name: "Test Garden", location: "Backyard", user: user) }
  let!(:plant) { Plant.first || Plant.create!(name: "Tomato", variety: "Cherry", user: user) }

  def log_in
    post login_path, params: { email: user.email, password: "password" }
  end

  context "when not logged in" do
    it "redirects GET /gardens/:garden_id/plantings to login" do
      get garden_plantings_path(garden)
      expect(response).to redirect_to(login_path)
    end

    it "redirects GET /plantings/:id to login" do
      planting = Planting.create!(garden: garden, plant: plant, user: user, date_planted: Date.today, season: "Spring", notes: "Test")
      get planting_path(planting)
      expect(response).to redirect_to(login_path)
    end

    it "redirects POST /gardens/:garden_id/plantings to login" do
      post garden_plantings_path(garden), params: {
        planting: {
          plant_id: plant.id,
          date_planted: Date.today,
          season: "Spring",
          notes: "Should not save"
        }
      }
      expect(response).to redirect_to(login_path)
    end

    it "redirects PATCH /plantings/:id to login" do
      planting = Planting.create!(
        garden: garden,
        plant: plant,
        user: user,
        date_planted: Date.today,
        season: "Spring",
        notes: "Test"
      )

      patch planting_path(planting), params: { planting: { notes: "Shouldn't update" } }
      expect(response).to redirect_to(login_path)
    end
  end

  context "when logged in" do
    before { log_in }

    describe "GET /gardens/:garden_id/plantings" do
  it "returns http success" do
    Planting.create!(
      garden: garden,
      plant: plant,
      user: user,
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880
      date_planted: Date.today,
      season: "Spring",
      notes: "Test notes"
    )
<<<<<<< HEAD
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
=======

    get garden_plantings_path(garden)
    expect(response).to have_http_status(:success)
  end
end


    describe "GET /plantings/:id" do
      it "returns http success" do
        planting = Planting.create!(
          garden: garden,
          plant: plant,
          user: user,
          date_planted: Date.today,
          season: "Spring",
          notes: "Test notes"
        )

        get planting_path(planting)
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /gardens/:garden_id/plantings" do
      context "with valid parameters" do
        it "creates a new planting and redirects" do
          expect {
            post garden_plantings_path(garden), params: {
              planting: {
                plant_id: plant.id,
                user_id: user.id,
                date_planted: Date.today,
                season: "Spring",
                notes: "Planted during testing"
              }
            }
          }.to change(Planting, :count).by(1)

          expect(response).to redirect_to(garden_plantings_path(garden))
          follow_redirect!
          expect(response.body).to include("Planted during testing")
        end
      end

      context "with invalid parameters" do
        it "does not create a planting and re-renders the form" do
          post garden_plantings_path(garden), params: {
            planting: {
              plant_id: nil,
              user_id: user.id,
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
          user: user,
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

          expect(response).to redirect_to(garden_plantings_path(garden))
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
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880
    end
  end
end
