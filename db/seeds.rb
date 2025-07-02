puts "👤 Seeding user..."
user = User.find_or_initialize_by(email: "tia@example.com")
user.first_name = "Tia"
user.last_name = "Anderson"
user.password = "password"
user.password_confirmation = "password"
user.save!

puts "🌿 Seeding garden..."
garden = Garden.find_or_initialize_by(name: "Home Garden", location: "Backyard")
garden.user = user
garden.save!

puts "🪴 Seeding plants and plantings..."
plants_data = [
  { name: "Roma Tomato", notes: "Needs support and regular pruning.", planted_on: Date.new(2025, 3, 5) },
  { name: "Green Grapes", notes: "Train vines on a sturdy trellis.", planted_on: Date.new(2024, 11, 1) },
  { name: "Yukon Gold Potatoes", notes: "Mound soil as plants grow.", planted_on: Date.new(2025, 3, 15) },
  { name: "Boston Pickling Cucumbers", notes: "Great for vertical growth.", planted_on: Date.new(2025, 4, 1) },
  { name: "Luffa Gourd", notes: "Trellis required. Long season.", planted_on: Date.new(2025, 4, 12) },
  { name: "Black Beauty Zucchini", notes: "Watch for vine borers.", planted_on: Date.new(2025, 5, 10) },
  { name: "Yellow Crookneck Squash", notes: "Harvest young for best flavor.", planted_on: Date.new(2025, 5, 12) },
  { name: "Sriracha Peppers", notes: "Start indoors, transplant after frost.", planted_on: Date.new(2025, 4, 15) },
  { name: "Red Bell Peppers", notes: "Mulch to retain moisture.", planted_on: Date.new(2025, 4, 18) },
  { name: "Raspberries", notes: "Perennial. Prune after fruiting.", planted_on: Date.new(2024, 12, 5) }
]

plants_data.each do |data|
  plant = Plant.find_or_create_by!(name: data[:name])
  plant.update!(notes: data[:notes]) if plant.notes.blank?

  Planting.create!(
    user: user,
    garden: garden,
    plant: plant,
    date_planted: data[:planted_on],
    notes: data[:notes]
  )
end


puts "🧘🏽‍♀️ Seeding journal categories..."
categories = [ 'Life Wins', 'Troubled Times', 'Gratitude', 'Random Thoughts' ].map do |name|
  Category.find_or_create_by!(name: name)
end

puts '📓 Clearing old journal entries...'
user.journal_entries.destroy_all

puts '📓 Seeding handcrafted journal entries...'
custom_entries = [
  [ "Sprouts of Joy", "My garden beds are thriving and it's such a peaceful sight.", "Life Wins", Date.new(2025, 3, 10) ],
  [ "Unsettled Soil", "Felt unsure about the future today.", "Troubled Times", Date.new(2025, 3, 12) ],
  [ "Heavy Hearts", "Today was hard. I felt overwhelmed by everything on my plate.", "Troubled Times", Date.new(2025, 3, 31) ],
  [ "Silent Showers", "The rain helped me cry quietly today.", "Random Thoughts", Date.new(2025, 4, 2) ],
  [ "Dewy Reflections", "The morning dew reminded me to slow down.", "Random Thoughts", Date.new(2025, 4, 28) ],
  [ "Hope in the Haze", "The fog gave me space to reflect.", "Gratitude", Date.new(2025, 4, 30) ],
  [ "Grateful Roots", "I’m grateful for the resilience I see in my garden and myself.", "Gratitude", Date.new(2025, 5, 6) ],
  [ "Sunny Strides", "Took a walk and felt the sun on my shoulders.", "Life Wins", Date.new(2025, 5, 5) ],
  [ "Inner Bloom", "I felt more like myself today.", "Life Wins", Date.new(2025, 5, 7) ],
  [ "Petals & Promises", "Seeing the flowers bloom gives me hope for what's ahead.", "Life Wins", Date.new(2025, 5, 30) ],
  [ "Sunset Stillness", "Watched the sunset in stillness and felt peace.", "Gratitude", Date.new(2025, 5, 26) ],
  [ "Roots & Ruminations", "Thought about the legacy I’m growing.", "Random Thoughts", Date.new(2025, 5, 28) ]
]

custom_entries.each do |title, content, category_name, date|
  JournalEntry.create!(
    title: title,
    content: content,
    created_at: date.to_time.beginning_of_day,
    updated_at: date.to_time.beginning_of_day,
    user: user,
    category: Category.find_by!(name: category_name)
  )
end

puts "🌦️ Seeding extra journal entries for layout testing..."

seeded_titles = [
  "Morning Calm", "Fresh Start", "Restless Energy", "Quiet Wins", "Simple Joys",
  "Late Bloom", "Cloudy Clarity", "Weekend Reset", "Moments of Grace", "Still Growing"
]

start_month = Date.new(2024, 10, 1)
end_month   = Date.new(2025, 6, 1)

months = (start_month..end_month).select { |d| d.day == 1 }

months.each_with_index do |month_start, i|
  next if i.odd?  # Skip every other month for visual gaps

  rand(2..3).times do |entry_num|
    date = month_start + rand(0..14).days
    unique_title = "#{seeded_titles.sample} #{date.strftime('%b %d')}"
    JournalEntry.find_or_create_by!(
      title: unique_title,
      created_at: date.to_time.beginning_of_day,
      user: user
    ) do |entry|
      entry.content = "This journal entry is auto-seeded for layout and display testing."
      entry.updated_at = date.to_time.beginning_of_day
      entry.category = categories.sample
    end
  end
end

puts "🌱 Seeding Complete!"
