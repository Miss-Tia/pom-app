class RecipesController < ApplicationController
<<<<<<< HEAD
=======
before_action :require_login
>>>>>>> b8467df9d29c21905f86a06c2840c65424c9a880
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
