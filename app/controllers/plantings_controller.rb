class PlantingsController < ApplicationController
  before_action :require_login
  before_action :set_planting, only: [ :show, :edit, :update, :destroy ]
  before_action :set_garden, only: [ :index, :new, :create ]

  def index
    @plantings = @garden.plantings.includes(:plant)
  end

  def show
  end

  def new
  @garden = Garden.find(params[:garden_id])
  @planting = @garden.plantings.build
  @plants = Plant.all
  end

  def create
    @planting = @garden.plantings.new(planting_params)
    @planting.user = current_user

    if @planting.save
      redirect_to garden_plantings_path(@garden), notice: "Planting created successfully!"
    else
      @plants = Plant.all.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  @planting = Planting.find(params[:id])
  @garden = @planting.garden
  @plants = Plant.all
  end

  def update
    Rails.logger.debug "🛠️ Attempting to update planting: #{planting_params.inspect}"
    if @planting.update(planting_params)
      Rails.logger.debug "✅ Update success: #{@planting.attributes}"
      redirect_to garden_plantings_path(@planting.garden), notice: "Planting updated successfully!"
    else
      Rails.logger.debug "❌ Update failed: #{@planting.errors.full_messages}"
      @plants = Plant.all.order(:name)
      @garden = @planting.garden
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden = @planting.garden
    @planting.destroy
    redirect_to garden_plantings_path(@garden), notice: "Planting deleted successfully."
  end

  private

  def set_planting
    @planting = current_user.plantings.find(params[:id])
  end

  def set_garden
    @garden = Garden.find(params[:garden_id])
  end

  def planting_params
    params.require(:planting).permit(:plant_id, :garden_id, :date_planted, :season, :notes)
  end
end
