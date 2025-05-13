# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts '🌱 Seeding categories...'

[ 'Life Wins', 'Troubled Times', 'Gratitude', 'Random Thoughts' ].each do |name|
  Category.find_or_create_by!(name: name)
  user = User.first || User.create!(
  first_name: "Tia",
  last_name: "Anderson",
  email: "tia@example.com"
)

recipes = [
  {
    title: "Garlic Herb Salmon",
    description: "Flaky salmon with a garlic herb butter sauce.",
    ingredients: "Salmon fillets\nButter\nGarlic\nParsley\nLemon\nOld Bay seasoning",
    instructions: "1. Preheat oven to 375°F.\n2. Melt butter with garlic and herbs.\n3. Pour over salmon and bake 20 minutes.",
    user: user
  },
  {
    title: "Mac & Cheese for the Littles",
    description: "Kid-approved creamy mac and cheese with a crispy top.",
    ingredients: "Macaroni\nCheddar cheese\nMilk\nButter\nBreadcrumbs",
    instructions: "1. Cook macaroni.\n2. Make cheese sauce.\n3. Mix, top with crumbs, and bake at 350°F until bubbly.",
    user: user
  },
  {
    title: "Garden Veggie Stir Fry",
    description: "A colorful medley of garden veggies sautéed to perfection.",
    ingredients: "Bell peppers\nZucchini\nOnions\nSoy sauce\nGarlic\nOlive oil",
    instructions: "1. Slice veggies.\n2. Sauté in oil with garlic.\n3. Add soy sauce and stir until crisp-tender.",
    user: user
  }
]

recipes.each do |data|
  Recipe.find_or_create_by!(title: data[:title], user: user) do |recipe|
    recipe.description = data[:description]
    recipe.ingredients = data[:ingredients]
    recipe.instructions = data[:instructions]

# Seed Garden and Plants
user = User.first || User.create!(first_name: "Tia", last_name: "Anderson", email: "tia@example.com")

garden = Garden.find_or_create_by!(name: "Backyard", location: "Fayetteville, NC", notes: "Main garden space", user: user)

plants = [
  { name: "Tomato", variety: "Roma", notes: "Needs trellising" },
  { name: "Bell Pepper", variety: "California Wonder", notes: "Loves sun" },
  { name: "Cucumber", variety: "Straight Eight", notes: "Vine needs support, fertilize heavily" }
]

plants.each do |attrs|
  Plant.find_or_create_by!(
    name: attrs[:name],
    variety: attrs[:variety],
    notes: attrs[:notes],
    planted_on: Date.today - rand(1..20).days,
    last_watered_on: Date.today - rand(1..3).days,
    last_fertilized_on: Date.today - rand(5..10).days,
    harvested_on: nil,
    garden: garden
  )
  puts "🌿 Seeding plantings..."

user = User.first
garden = Garden.first
plants = Plant.limit(3)

plants.each_with_index do |plant, i|
  Planting.find_or_create_by!(
    garden: garden,
    plant: plant,
    location: "Bed #{i + 1}",
    date_planted: Date.today - (i * 3).days,
    season: "Spring",
    notes: "Planted #{plant.name} with love."
  )
end
end
  end
end
end
