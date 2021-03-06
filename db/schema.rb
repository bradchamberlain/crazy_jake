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

ActiveRecord::Schema.define(version: 20140209202036) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "complete_surveys", force: true do |t|
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "responses"
    t.hstore   "custom_values"
    t.string   "ip_address"
  end

  add_index "complete_surveys", ["survey_id"], name: "index_complete_surveys_on_survey_id", using: :btree

  create_table "customers", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "menu_text_color"
    t.string   "menu_bg_color"
    t.string   "body_text_color"
    t.string   "body_bg_color"
    t.date     "payment_received"
    t.string   "payment_token"
    t.decimal  "monthly_cost",      default: 10.0
  end

  create_table "questions", force: true do |t|
    t.text     "text"
    t.integer  "index"
    t.integer  "survey_id"
    t.boolean  "yes_no"
    t.boolean  "rating"
    t.boolean  "free_form"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "customized"
    t.text     "custom_values"
    t.integer  "custom_type"
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree

  create_table "reporting_fields", force: true do |t|
    t.string   "field_title"
    t.text     "field_values"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
  end

  add_index "reporting_fields", ["survey_id"], name: "index_reporting_fields_on_survey_id", using: :btree

  create_table "surveys", force: true do |t|
    t.text     "name"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "complete_message"
    t.integer  "tracking_type_id"
  end

  add_index "surveys", ["customer_id"], name: "index_surveys_on_customer_id", using: :btree
  add_index "surveys", ["tracking_type_id"], name: "index_surveys_on_tracking_type_id", using: :btree

  create_table "tracking_types", force: true do |t|
    t.string   "description"
    t.integer  "days"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.boolean  "admin",                  default: false
    t.string   "name"
    t.boolean  "master_user",            default: false
  end

  add_index "users", ["customer_id"], name: "index_users_on_customer_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
