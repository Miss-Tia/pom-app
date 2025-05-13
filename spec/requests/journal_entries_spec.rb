require 'rails_helper'

RSpec.describe "JournalEntries", type: :request do
  let(:user) { User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com") }
  let(:category) { Category.find_or_create_by!(name: "Life Wins") }

  before do
    @entry = JournalEntry.create!(
      title: "Lesson Learned",
      content: "Today I learned how to write a request spec!",
      category: category,
      user: user
    )
  end

  describe "GET /journal_entries" do
    it "returns a successful response" do
      get journal_entries_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Lesson Learned")
    end
  end

  describe "GET /journal_entries/:id" do
    it "shows the individual journal entry" do
      get journal_entry_path(@entry)
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Today I learned how to write a request spec!")
    end
  end
end
