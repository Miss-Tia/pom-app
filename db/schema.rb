# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_04_09_034052) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "notes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_gardens_on_user_id"
  end

  create_table "journal_entries", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_journal_entries_on_category_id"
    t.index ["user_id"], name: "index_journal_entries_on_user_id"
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "variety"
    t.text "notes"
    t.date "planted_on"
    t.date "last_watered_on"
    t.date "last_fertilized_on"
    t.date "harvested_on"
    t.integer "garden_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_plants_on_garden_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "ingredients"
    t.text "instructions"
    t.integer "user_id", null: false
    t.integer "journal_entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["journal_entry_id"], name: "index_recipes_on_journal_entry_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "gardens", "users"
  add_foreign_key "journal_entries", "categories"
  add_foreign_key "journal_entries", "users"
  add_foreign_key "plants", "gardens"
  add_foreign_key "recipes", "journal_entries"
  add_foreign_key "recipes", "users"
end
