class RecipesController < ApplicationController
before_action :require_login
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
