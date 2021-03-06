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

ActiveRecord::Schema.define(version: 20181201215400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.integer "company_id"
    t.integer "question_id"
    t.string  "level"
    t.boolean "validated",   default: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "description"
    t.float  "weight_sum"
  end

  create_table "coa_weights", force: :cascade do |t|
    t.integer "coa_id"
    t.integer "company_id"
    t.float   "weight"
  end

  create_table "coas", force: :cascade do |t|
    t.string  "coa_index"
    t.string  "description"
    t.integer "self_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.float  "company_score"
    t.string "description"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "keyword"
    t.integer  "index"
    t.integer  "answer"
    t.string   "description"
    t.float    "weight"
    t.integer  "subcategory_id"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["keyword"], name: "index_questions_on_keyword", unique: true, using: :btree

  create_table "scales", force: :cascade do |t|
    t.integer "level"
    t.float   "score"
    t.string  "description"
    t.integer "category_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "company_id"
    t.integer "subcategory_id"
    t.float   "value"
    t.integer "category_id"
    t.string  "is_category_score"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string  "subcategory_index"
    t.float   "weight"
    t.string  "description"
    t.float   "weight_sum"
    t.integer "category_id"
  end

  create_table "subs", id: false, force: :cascade do |t|
    t.integer "company_id"
    t.integer "sub_company_id"
  end

  add_index "subs", ["company_id", "sub_company_id"], name: "index_subs_on_company_id_and_sub_company_id", unique: true, using: :btree
  add_index "subs", ["sub_company_id", "company_id"], name: "index_subs_on_sub_company_id_and_company_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.integer  "company_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "users", "companies"
end
