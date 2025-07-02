require 'rails_helper'

RSpec.describe "Recipes", type: :request do
<<<<<<< HEAD
  describe "GET /recipes" do
    it "returns a successful response" do
      get recipes_path
      expect(response).to have_http_status(:success)
    end

    it "displays a list of recipe titles" do
      user = User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com")
      recipe = Recipe.create!(
        title: "Test Recipe",
        description: "Just a test",
        ingredients: "Love\nCode",
        instructions: "1. Mix\n2. Build\n3. Deploy",
        user: user
      )

      get recipes_path
      expect(response.body).to include("Test Recipe")
    end
  end

  describe "GET /recipes/:id" do
    it "shows the recipe details" do
      user = User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com")
      recipe = Recipe.create!(
        title: "View Test Recipe",
        description: "See if it renders",
        ingredients: "Hope\nMagic",
        instructions: "1. Click\n2. Read\n3. Smile",
        user: user
      )
      get recipe_path(recipe)
      expect(response.body).to include("View Test Recipe")
      expect(response.body).to include("See if it renders")
=======
  let!(:user) { User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com", password: "password", password_confirmation: "password") }

  def log_in
    post login_path, params: { email: user.email, password: "password" }
  end

  context "when not logged in" do
    it "redirects GET /recipes to login" do
      get recipes_path
      expect(response).to redirect_to(login_path)
    end

    it "redirects GET /recipes/:id to login" do
      recipe = Recipe.create!(
        title: "Redirect Test Recipe",
        description: "You shouldn't see this",
        ingredients: "None",
        instructions: "Nada",
        user: user
      )
      get recipe_path(recipe)
      expect(response).to redirect_to(login_path)
    end
  end

  context "when logged in" do
    before { log_in }

    describe "GET /recipes" do
      it "returns a successful response" do
        get recipes_path
        expect(response).to have_http_status(:success)
      end

      it "displays a list of recipe titles" do
        recipe = Recipe.create!(
          title: "Test Recipe",
          description: "Just a test",
          ingredients: "Love\nCode",
          instructions: "1. Mix\n2. Build\n3. Deploy",
          user: user
        )

        get recipes_path
        expect(response.body).to include("Test Recipe")
      end
    end

    describe "GET /recipes/:id" do
      it "shows the recipe details" do
        recipe = Recipe.create!(
          title: "View Test Recipe",
          description: "See if it renders",
          ingredients: "Hope\nMagic",
          instructions: "1. Click\n2. Read\n3. Smile",
          user: user
        )
        get recipe_path(recipe)
        expect(response.body).to include("View Test Recipe")
        expect(response.body).to include("See if it renders")
      end
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880
    end
  end
end
