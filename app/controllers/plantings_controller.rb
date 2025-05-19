class PlantingsController < ApplicationController
  def index
    @plantings = Planting.includes(:plant, :garden)
  end

  def show
    @planting = Planting.find(params[:id])
  end
end
