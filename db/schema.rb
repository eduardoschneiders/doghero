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

ActiveRecord::Schema.define(version: 2019_07_02_043252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caregivers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_dogs_on_client_id"
  end

  create_table "dogs_walkings", id: false, force: :cascade do |t|
    t.bigint "dog_id", null: false
    t.bigint "walking_id", null: false
    t.index ["dog_id", "walking_id"], name: "index_dogs_walkings_on_dog_id_and_walking_id"
    t.index ["walking_id", "dog_id"], name: "index_dogs_walkings_on_walking_id_and_dog_id"
  end

  create_table "walkings", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "lat"
    t.integer "lon"
    t.bigint "caregiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caregiver_id"], name: "index_walkings_on_caregiver_id"
  end

  add_foreign_key "dogs", "clients"
end
