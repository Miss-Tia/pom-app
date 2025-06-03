class JournalEntriesController < ApplicationController
  before_action :require_login
  def index
    @journal_entries = JournalEntry.all
  end

  def show
    @journal_entry = JournalEntry.find(params[:id])
  end
end
