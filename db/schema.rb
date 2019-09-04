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

ActiveRecord::Schema.define(version: 2019_09_04_155343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "roles", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "collectives", force: :cascade do |t|
    t.string "city"
    t.string "head_full_name"
    t.string "title"
    t.string "level"
  end

  create_table "event_dates", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "event_date"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_event_dates_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.integer "event_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nomination_styles", force: :cascade do |t|
    t.bigint "nomination_id"
    t.bigint "style_id"
    t.integer "priority"
    t.index ["nomination_id"], name: "index_nomination_styles_on_nomination_id"
    t.index ["style_id"], name: "index_nomination_styles_on_style_id"
  end

  create_table "nominations", force: :cascade do |t|
    t.string "title"
    t.integer "age_from"
    t.integer "age_to"
    t.bigint "event_id"
    t.bigint "event_date_id"
    t.bigint "performance_format_id"
    t.index ["event_date_id"], name: "index_nominations_on_event_date_id"
    t.index ["event_id"], name: "index_nominations_on_event_id"
    t.index ["performance_format_id"], name: "index_nominations_on_performance_format_id"
  end

  create_table "performance_formats", force: :cascade do |t|
    t.string "title"
    t.integer "participants_count_from"
    t.integer "participants_count_to"
  end

  create_table "performances", force: :cascade do |t|
    t.bigint "collective_id"
    t.bigint "event_date_id"
    t.integer "age_from"
    t.integer "age_to"
    t.string "style"
    t.string "choreographer_full_name"
    t.integer "participants_count"
    t.string "title"
    t.boolean "from_dot", default: false
    t.integer "priority"
    t.integer "status"
    t.bigint "nomination_id"
    t.bigint "style_id"
    t.index ["collective_id"], name: "index_performances_on_collective_id"
    t.index ["event_date_id"], name: "index_performances_on_event_date_id"
    t.index ["nomination_id"], name: "index_performances_on_nomination_id"
    t.index ["style_id"], name: "index_performances_on_style_id"
  end

  create_table "styles", force: :cascade do |t|
    t.string "title"
    t.string "comment"
  end

  add_foreign_key "event_dates", "events"
  add_foreign_key "nomination_styles", "nominations"
  add_foreign_key "nomination_styles", "styles"
  add_foreign_key "nominations", "event_dates"
  add_foreign_key "nominations", "performance_formats"
  add_foreign_key "performances", "collectives"
  add_foreign_key "performances", "event_dates"
  add_foreign_key "performances", "nominations"
  add_foreign_key "performances", "styles"
end
