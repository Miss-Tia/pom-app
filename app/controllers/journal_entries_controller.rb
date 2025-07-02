class JournalEntriesController < ApplicationController
  before_action :require_login
  before_action :set_journal_entry, only: [ :show, :edit, :update, :destroy ]

  def index
  entries = current_user.journal_entries.order(created_at: :desc)

  # Group entries by the first day of the month (as a DATE, not Time)
  grouped_entries = entries.group_by { |e| e.created_at.to_date.beginning_of_month }

  # Establish range of months (as DATEs) to display
  earliest_date = entries.minimum(:created_at)&.to_date&.beginning_of_month || Time.current.to_date.beginning_of_month
  current_date  = Time.current.to_date.beginning_of_month

  all_months = (earliest_date..current_date).select { |d| d.day == 1 }

  @entries_by_month = all_months.reverse.index_with { |month| grouped_entries[month] || [] }
  end



  def new
    @journal_entry = current_user.journal_entries.new
  end

  def create
    @journal_entry = current_user.journal_entries.new(journal_entry_params)
    if @journal_entry.save
      redirect_to journal_entry_path(@journal_entry), notice: "Journal entry created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @journal_entry is set by before_action
  end

  def edit
    # @journal_entry is set by before_action
  end

  def update
    if @journal_entry.update(journal_entry_params)
      redirect_to journal_entry_path(@journal_entry), notice: "Entry updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @journal_entry.destroy
    redirect_to journal_entries_path, notice: "Journal entry deleted."
  end

  private

  def set_journal_entry
    @journal_entry = current_user.journal_entries.find(params[:id])
  end

  def journal_entry_params
    params.require(:journal_entry).permit(:title, :content, :category_id, :prompt)
  end
end
