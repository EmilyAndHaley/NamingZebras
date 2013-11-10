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

ActiveRecord::Schema.define(version: 20131105013923) do

  create_table "diseases", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symptoms", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "signid"
  end

  create_table "users", force: true do |t|
    t.string   "firstName",                                      null: false
    t.string   "lastName",                                       null: false
    t.string   "middleName"
    t.datetime "DOB"
    t.string   "sex",                    limit: 1
    t.string   "cAddress"
    t.string   "telephone",              limit: 25
    t.string   "race"
    t.string   "ethnicity"
    t.string   "nationality"
    t.string   "occupation"
    t.datetime "YOD"
    t.string   "birthOrigin"
    t.integer  "houseSize"
    t.string   "groupHouse"
    t.string   "biologicalParent"
    t.string   "gestation"
    t.integer  "births"
    t.string   "eyeColor"
    t.string   "contact",                limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_diseases", force: true do |t|
    t.integer  "users_id"
    t.integer  "disease_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users_diseases", ["disease_id"], name: "index_users_diseases_on_disease_id", using: :btree
  add_index "users_diseases", ["users_id"], name: "index_users_diseases_on_users_id", using: :btree

  create_table "users_symptoms", force: true do |t|
    t.integer  "users_id"
    t.integer  "symptoms_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "startDate"
    t.integer  "frequency"
  end

  add_index "users_symptoms", ["symptoms_id"], name: "index_users_symptoms_on_symptoms_id", using: :btree
  add_index "users_symptoms", ["users_id"], name: "index_users_symptoms_on_users_id", using: :btree

end
