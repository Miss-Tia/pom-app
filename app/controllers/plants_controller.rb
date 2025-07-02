# app/controllers/plants_controller.rb
class PlantsController < ApplicationController
  before_action :require_login
  before_action :set_plant, only: [ :show, :edit, :update, :destroy ]

  def new
  @garden = Garden.find_by(id: params[:garden_id])
  raise ActiveRecord::RecordNotFound, "Garden ID is required to add a plant." unless @garden

  @plant = Plant.new
  end

  def create
  @plant = Plant.new(plant_params)
  @plant.user = current_user # Make sure everyone's plants are associated with their user

  if @plant.save
    garden_id = params[:garden_id] # from query string
    if garden_id.present?
      redirect_to new_garden_planting_path(garden_id, selected_plant_id: @plant.id),
                  notice: "🌿 Plant added! You can now select it in your new planting."
    else
      redirect_to gardens_path, notice: "🌿 Plant added!"
    end
  else
    render :new, status: :unprocessable_entity
  end
  end


  def show; end

  def edit; end

  def update
    if @plant.update(plant_params)
      redirect_to plant_path(@plant), notice: "Plant updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plant.destroy
    redirect_to dashboard_path(current_user), notice: "Plant deleted."
  end

  private

  def set_plant
    @plant = Plant.find(params[:id])
  end

  def plant_params
    params.require(:plant).permit(:name, :notes, :days_to_harvest)
  end
end
def create
  @plant = Plant.new(plant_params)
  if @plant.save
    garden_id = params[:garden_id] # from query string
    if garden_id.present?
      redirect_to new_garden_planting_path(garden_id), notice: "🌿 Plant added! You can now select it in your new planting."
    else
      redirect_to gardens_path, notice: "🌿 Plant added!"
    end
  else
    render :new, status: :unprocessable_entity
  end
end
