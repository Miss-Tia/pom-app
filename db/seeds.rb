# db/seeds.rb

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


recipes.each do |data|
  Recipe.find_or_create_by!(title: data[:title], user: user) do |r|
    r.description = data[:description]
    r.ingredients = data[:ingredients]
    r.instructions = data[:instructions]
  end
end
puts '🌱 Seeding complete...'
