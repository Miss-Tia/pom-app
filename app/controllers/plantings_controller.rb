class PlantingsController < ApplicationController
  before_action :require_login
  before_action :set_planting, only: [ :show, :edit, :update, :destroy, :add_progress_note ]
  before_action :set_garden, only: [ :index, :new, :create ]

  def index
    @plantings = @garden.plantings.includes(:plant)
  end

  def show
    # @planting is already set via before_action
  end

  def new
    @planting = @garden.plantings.build
    @plants = current_user.plants
    @selected_plant_id = params[:selected_plant_id]
    @planting.plant_id = @selected_plant_id if @selected_plant_id.present?
  end

  def create
    @planting = @garden.plantings.new(planting_params)
    @planting.user = current_user

    if @planting.save
      redirect_to garden_plantings_path(@garden), notice: "Planting created successfully!"
    else
      @plants = current_user.plants.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @garden = @planting.garden
    @plants = current_user.plants
  end

  def update
    Rails.logger.debug "🛠️ Attempting to update planting: #{planting_params.inspect}"
    if @planting.update(planting_params)
      Rails.logger.debug "✅ Update success: #{@planting.attributes}"
      redirect_to garden_plantings_path(@planting.garden), notice: "Planting updated successfully!"
    else
      Rails.logger.debug "❌ Update failed: #{@planting.errors.full_messages}"
      @plants = current_user.plants.order(:name)
      @garden = @planting.garden
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @garden = @planting.garden
    @planting.destroy
    redirect_to garden_plantings_path(@garden), notice: "Planting deleted successfully."
  end

  def add_progress_note
  @planting = Planting.find(params[:id])

  # Add new notes at the top
  new_note = {
    "content" => params[:content],
    "timestamp" => Time.current
  }

  @planting.progress_notes.unshift(new_note)
  @planting.save

  # Add the index manually for rendering
  note_with_index = new_note.merge("index" => 0)

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.prepend(
        "progress-notes-list",
        partial: "plantings/note",
        locals: { note: note_with_index }
      )
    end
    format.html { redirect_to planting_path(@planting), notice: "Note added!" }
  end
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
