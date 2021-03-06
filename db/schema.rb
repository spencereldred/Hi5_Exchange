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

ActiveRecord::Schema.define(version: 20151128163722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "member_count"
    t.string   "promo_code"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "email"
    t.string   "function"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "radius",     default: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "group_id"
    t.integer  "recycler_user_id"
    t.integer  "redeemer_user_id"
    t.datetime "selection_date"
    t.datetime "completion_date"
    t.integer  "rating"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.boolean  "selected",         default: false
    t.boolean  "completed",        default: false
    t.integer  "plastic"
    t.integer  "cans"
    t.integer  "glass"
    t.integer  "other"
    t.boolean  "cardboard",        default: false
    t.boolean  "non_hi5_plastic",  default: false
    t.boolean  "non_hi5_cans",     default: false
    t.boolean  "non_hi5_glass",    default: false
    t.boolean  "magazines",        default: false
    t.boolean  "newspaper",        default: false
    t.boolean  "paper",            default: false
    t.string   "trans_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
