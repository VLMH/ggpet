# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_05_09_105326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoptions", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "pet_id"
    t.integer "status", limit: 2, default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "pet_id"], name: "index_adoptions_on_customer_id_and_pet_id", unique: true
    t.index ["customer_id"], name: "index_adoptions_on_customer_id"
    t.index ["pet_id"], name: "index_adoptions_on_pet_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.jsonb "preferences"
    t.integer "preference_age_min", default: 0, null: false
    t.integer "preference_age_max", default: 500, null: false, comment: "assume pets have max 500 age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["preferences"], name: "index_customers_on_preferences", using: :gin
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age"
    t.string "species", default: "", null: false
    t.string "breed", default: "", null: false
    t.datetime "available_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "adopted_by"
    t.index ["adopted_by"], name: "index_pets_on_adopted_by"
    t.index ["species"], name: "index_pets_on_species"
  end

  add_foreign_key "adoptions", "customers"
  add_foreign_key "adoptions", "pets"
end
