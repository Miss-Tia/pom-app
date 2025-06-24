class Planting < ApplicationRecord
  belongs_to :plant
  belongs_to :garden
  belongs_to :user

  validates :plant_id, presence: true
  validates :garden_id, presence: true
  validates :date_planted, presence: true
  validates :notes, length: { maximum: 500 }

  validate :date_planted_cannot_be_in_the_future


  def date_planted_cannot_be_in_the_future
    if date_planted.present? && date_planted > Date.today
      errors.add(:date_planted, "can't be in the future")
    end
  end

  # Add a progress note w/timestamp
  after_initialize do
  self.progress_notes ||= []
end

def add_progress_note(content)
  timestamped_note = {
    content: content,
    added_at: Time.current
  }
  self.progress_notes << timestamped_note
  save
end
end
