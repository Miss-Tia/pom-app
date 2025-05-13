require 'rails_helper'

RSpec.describe Plant, type: :model do
  it 'is valid with valid attributes' do
    garden = Garden.create!(name: "Test Garden", location: "Backyard", user: User.create!(name: "Tia", email: "tia@example.com"))
    plant = Plant.new(
      name: "Tomato",
      variety: "Cherry",
      notes: "Sweet and juicy",
      planted_on: Date.today,
      garden: garden
    )

    expect(plant).to be_valid
  end
end
