require 'rails_helper'

RSpec.describe "JournalEntries", type: :request do
  let!(:user) do
    User.first || User.create!(
      first_name: "Tia",
      last_name: "Anderson",
      email: "tia@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  let!(:category) { Category.find_or_create_by!(name: "Life Wins") }

  def log_in
    post login_path, params: { email: user.email, password: "password" }
  end

  let!(:entry) do
    JournalEntry.create!(
      title: "Lesson Learned",
      content: "Today I learned how to write a request spec!",
      category: category,
      user: user
    )
  end

  context "when not logged in" do
    it "redirects GET /journal_entries to login" do
      get journal_entries_path
      expect(response).to redirect_to(login_path)
    end

    it "redirects GET /journal_entries/:id to login" do
      get journal_entry_path(entry)
      expect(response).to redirect_to(login_path)
    end
  end

  context "when logged in" do
    before { log_in }

    describe "GET /journal_entries" do
      it "returns a successful response and shows entries" do
        get journal_entries_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Lesson Learned")
      end
    end

    describe "GET /journal_entries/:id" do
      it "shows the individual journal entry" do
        get journal_entry_path(entry)
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Today I learned how to write a request spec!")
      end
    end
  end
end
