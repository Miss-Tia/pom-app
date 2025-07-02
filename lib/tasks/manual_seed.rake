# lib/tasks/manual_seed.rake

namespace :manual do
  desc "Run db:seed in production manually"
  task seed: :environment do
    puts "🌱 Seeding database..."
    load(Rails.root.join("db", "seeds.rb"))
    puts "✅ Done!"
  end
end
