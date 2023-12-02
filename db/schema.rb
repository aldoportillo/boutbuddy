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

ActiveRecord::Schema[7.0].define(version: 2023_12_02_211552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bouts", force: :cascade do |t|
    t.integer "event_id"
    t.integer "weight_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "time"
    t.integer "price"
    t.string "bio"
    t.integer "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "promoter_id"
    t.string "photo"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bout_id"
    t.string "corner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.bigint "bout_id", null: false
    t.integer "winner_id"
    t.integer "win_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bout_id"], name: "index_results_on_bout_id"
  end

  create_table "swipes", force: :cascade do |t|
    t.integer "swiper_id"
    t.integer "swiped_id"
    t.boolean "like"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.integer "weight"
    t.integer "reach"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "role"
    t.integer "weight_class_id"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "promoter_id"
  end

  create_table "weight_classes", force: :cascade do |t|
    t.string "name"
    t.float "min"
    t.float "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "win_bies", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "results", "bouts"
end
