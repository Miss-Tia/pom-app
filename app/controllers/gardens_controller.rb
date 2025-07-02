class GardensController < ApplicationController
  before_action :require_login
  before_action :set_garden, only: [ :show, :edit, :update, :destroy ]

  def index
    @gardens = current_user.gardens
  end

  def new
    @garden = current_user.gardens.new
  end

  def create
    @garden = current_user.gardens.new(garden_params)
    if @garden.save
      redirect_to gardens_path, notice: "Garden created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @garden is set by before_action
  end

  def edit; end # reserved for future

  def update
    if @garden.update(garden_params)
      redirect_to gardens_path, notice: "Garden updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path, notice: "Garden deleted successfully."
  end

  private

  def set_garden
    @garden = current_user.gardens.find(params[:id])
  end

  def garden_params
    params.require(:garden).permit(:name, :location, :notes)
  end
end
