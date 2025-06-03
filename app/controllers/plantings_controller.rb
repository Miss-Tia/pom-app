# app/controllers/plantings_controller.rb
class PlantingsController < ApplicationController
  before_action :require_login
  before_action :set_planting, only: [ :show, :edit, :update ]

  def index
    @plantings = Planting.includes(:plant, :garden)
  end

  def show
  end

  def new
    @planting = Planting.new
  end

  def create
    @planting = Planting.new(planting_params)
    if @planting.save
      redirect_to @planting, notice: "Planting created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @planting.update(planting_params)
      redirect_to @planting, notice: "Planting updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_planting
    @planting = Planting.find(params[:id])
  end

  def planting_params
    params.require(:planting).permit(:plant_id, :garden_id, :date_planted, :season, :notes)
  end
end
