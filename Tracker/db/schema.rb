# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160419173731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builder", primary_key: "builder_id", force: true do |t|
    t.string "name_of_builder", limit: 100, null: false
  end

  create_table "home", primary_key: "home_id", force: true do |t|
    t.string   "home_name",    limit: 100
    t.integer  "home_number"
    t.string   "home_address", limit: 100
    t.string   "city",         limit: 100
    t.string   "state",        limit: 100
    t.string   "zip",          limit: 5
    t.string   "notes",        limit: 10000
    t.integer  "parade_id"
    t.integer  "builder_id"
    t.datetime "time_stamp",                 default: "now()", null: false
  end

  create_table "order_table", primary_key: "order_id", force: true do |t|
    t.integer  "num_package_photos"
    t.integer  "raw_photos"
    t.datetime "raw_photos_date"
    t.integer  "estimated_photos"
    t.string   "photos_approved",          limit: 2
    t.datetime "photos_approved_date"
    t.string   "photographer_paid",        limit: 2
    t.datetime "photographer_paid_date"
    t.string   "quick_edit_upload",        limit: 2
    t.datetime "quick_edit_upload_date"
    t.string   "assigned_to_editor",       limit: 2
    t.datetime "assigned_to_editor_date"
    t.string   "final_edits_approve",      limit: 2
    t.datetime "final_edits_approve_date"
    t.integer  "final_photos_num"
    t.string   "final_cropping",           limit: 2
    t.datetime "final_cropping_date"
    t.string   "final_edit_upload",        limit: 2
    t.datetime "final_edit_upload_date"
    t.integer  "home_id"
    t.integer  "photographer_id"
    t.datetime "time_stamp",                         default: "now()", null: false
  end

  create_table "package", primary_key: "package_id", force: true do |t|
    t.integer  "number_of_photos"
    t.string   "notes_of_package", limit: 10000
    t.datetime "time_stamp",                     default: "now()", null: false
    t.string   "name",             limit: 1000
  end

  create_table "parade", primary_key: "parade_id", force: true do |t|
    t.string   "name_of_parade",       limit: 1000,                    null: false
    t.string   "city_of_parade",       limit: 100
    t.string   "state_of_parade",      limit: 100
    t.datetime "start_date_of_parade"
    t.datetime "end_date_of_parade"
    t.string   "parade_notes",         limit: 10000
    t.datetime "time_stamp",                         default: "now()", null: false
  end

  create_table "photographer", primary_key: "photographer_id", force: true do |t|
    t.string   "name_of_photographer",         limit: 100,                    null: false
    t.string   "email_of_photographer",        limit: 100
    t.string   "phone_number_of_photographer", limit: 14
    t.string   "notes_of_photographer",        limit: 1000
    t.datetime "time_stamp",                                default: "now()", null: false
    t.string   "swag",                         limit: 2
  end

  create_table "user2s", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "oauth_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_table", id: false, force: true do |t|
    t.string   "first_name", limit: 100
    t.string   "last_name",  limit: 100
    t.string   "email",      limit: 1000
    t.string   "user_id",    limit: 1000
    t.datetime "time_stamp",              default: "now()", null: false
  end

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "email"
    t.string   "oauth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
