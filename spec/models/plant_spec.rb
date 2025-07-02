require 'rails_helper'

RSpec.describe Plant, type: :model do
  it "is valid with valid attributes" do
    user = User.create!(
      first_name: "Tia",
      email: "tia@example.com",
      password: "password123"
    )
    garden = Garden.create!(name: "Test Garden", location: "Backyard", user: user)
    plant = Plant.new(name: "Tomato", variety: "Cherry", user: user)
    expect(plant).to be_valid
  end
  it "has many plantings" do
  assoc = described_class.reflect_on_association(:plantings)
  expect(assoc.macro).to eq :has_many
end
end
