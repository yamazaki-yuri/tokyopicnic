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

ActiveRecord::Schema[7.1].define(version: 2024_05_15_061655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "park_images", force: :cascade do |t|
    t.bigint "park_id", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_park_images_on_park_id"
  end

  create_table "park_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "park_id", null: false
    t.bigint "tokyo_ward_id", null: false
    t.date "date"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.index ["park_id"], name: "index_park_reports_on_park_id"
    t.index ["tokyo_ward_id"], name: "index_park_reports_on_tokyo_ward_id"
    t.index ["user_id"], name: "index_park_reports_on_user_id"
  end

  create_table "park_tokyo_wards", force: :cascade do |t|
    t.bigint "park_id", null: false
    t.bigint "tokyo_ward_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id", "tokyo_ward_id"], name: "index_park_tokyo_wards_on_park_id_and_tokyo_ward_id", unique: true
    t.index ["park_id"], name: "index_park_tokyo_wards_on_park_id"
    t.index ["tokyo_ward_id"], name: "index_park_tokyo_wards_on_tokyo_ward_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "name", null: false
    t.string "googlemaps_place_id", null: false
    t.string "website_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fee"
    t.integer "food_allowed", default: 2
    t.integer "alcohol_allowed", default: 2
    t.integer "sheet_available", default: 2
    t.integer "bringing_in_play_equipment", default: 2
    t.index ["googlemaps_place_id"], name: "index_parks_on_googlemaps_place_id", unique: true
  end

  create_table "report_images", force: :cascade do |t|
    t.bigint "park_report_id", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_report_id"], name: "index_report_images_on_park_report_id"
  end

  create_table "sns_credentials", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id"
  end

  create_table "tokyo_wards", force: :cascade do |t|
    t.string "name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "park_images", "parks"
  add_foreign_key "park_reports", "parks"
  add_foreign_key "park_reports", "tokyo_wards"
  add_foreign_key "park_reports", "users"
  add_foreign_key "park_tokyo_wards", "parks"
  add_foreign_key "park_tokyo_wards", "tokyo_wards"
  add_foreign_key "report_images", "park_reports"
  add_foreign_key "sns_credentials", "users"
end
