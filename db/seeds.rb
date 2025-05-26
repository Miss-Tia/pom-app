puts '🌱 Seeding categories...'
[ 'Life Wins', 'Troubled Times', 'Gratitude', 'Random Thoughts' ].each do |name|
  Category.find_or_create_by!(name: name)
end

puts '👤 Seeding user...'
user = User.find_or_create_by!(email: "tia@example.com") do |u|
  u.first_name = "Tia"
  u.last_name = "Anderson"
end

puts '📍 Seeding garden...'
garden = Garden.find_or_create_by!(name: "Backyard", location: "Fayetteville, NC", user: user) do |g|
  g.notes = "Main garden space"
end

puts '🍴 Seeding recipes...'
recipes = [
  {
    title: "Garlic Herb Salmon",
    description: "Flaky salmon with a garlic herb butter sauce.",
    ingredients: "Salmon fillets\nButter\nGarlic\nParsley\nLemon\nOld Bay seasoning",
    instructions: "1. Preheat oven to 375°F.\n2. Melt butter with garlic and herbs.\n3. Pour over salmon and bake 20 minutes."
  },
  {
    title: "Mac & Cheese for the Littles",
    description: "Kid-approved creamy mac and cheese with a crispy top.",
    ingredients: "Macaroni\nCheddar cheese\nMilk\nButter\nBreadcrumbs",
    instructions: "1. Cook macaroni.\n2. Make cheese sauce.\n3. Mix, top with crumbs, and bake at 350°F until bubbly."
  },
  {
    title: "Garden Veggie Stir Fry",
    description: "A colorful medley of garden veggies sautéed to perfection.",
    ingredients: "Bell peppers\nZucchini\nOnions\nSoy sauce\nGarlic\nOlive oil",
    instructions: "1. Slice veggies.\n2. Sauté in oil with garlic.\n3. Add soy sauce and stir until crisp-tender."
  }
]

recipes.each do |data|
  Recipe.find_or_create_by!(title: data[:title], user: user) do |r|
    r.description = data[:description]
    r.ingredients = data[:ingredients]
    r.instructions = data[:instructions]
  end
end

puts '🌿 Seeding plants...'
plants = [
  { name: "Tomato", variety: "Roma", notes: "Needs trellising" },
  { name: "Bell Pepper", variety: "California Wonder", notes: "Loves sun" },
  { name: "Cucumber", variety: "Straight Eight", notes: "Vine needs support" },
  { name: "Luffa", variety: "Chinese Okra", notes: "Long grow season" },
  { name: "Grapes", variety: "Concord", notes: "Train on trellis" },
  { name: "Pumpkin", variety: "Sugar Pie", notes: "Space hog!" },
  { name: "Asparagus", variety: "Mary Washington", notes: "Perennial — don't harvest year 1" }
]

plants.each do |attrs|
  Plant.find_or_create_by!(name: attrs[:name], variety: attrs[:variety], garden: garden) do |p|
    p.notes = attrs[:notes]
    p.planted_on = Date.today - rand(1..20).days
    p.last_watered_on = Date.today - rand(1..3).days
    p.last_fertilized_on = Date.today - rand(5..10).days
    p.harvested_on = nil
  end
end

puts '🪴 Seeding plantings...'
Plant.where(garden: garden).each_with_index do |plant, i|
  Planting.find_or_create_by!(
    garden: garden,
    plant: plant,
    location: "Bed #{i + 1}",
    date_planted: Date.today - (i * 3).days,
    season: "Spring",
    notes: "Planted #{plant.name} with love."
  )
end

puts '✅ Done seeding!'
