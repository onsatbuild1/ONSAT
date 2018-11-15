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

ActiveRecord::Schema.define(version: 20111119180638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string  "description"
    t.float   "weight_sum"
  end
  
  create_table "answer", force: :cascade do |t|
    t.integer "company_id"
    t.integer "questions_id"
    t.string  "level"
  end

  create_table "company", force: :cascade do |t|
    t.string "name"
    t.float  "score"
    t.string "description"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "index"
    t.string   "keyword"
    t.string   "description"
    t.integer  "answer"
    t.float    "weight"
    t.integer  "subcategory_id"
    #t.string   "category",       limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scales", force: :cascade do |t|
    t.integer "level"
    t.float   "score"
    t.string  "description"
    t.string  "category",    limit: 1
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "subcategory_index"
    t.float  "weight"
    t.string "description"
    #t.string "category",          limit: 1
    t.float  "weight_sum"
    t.integer "category_id"
  end

end
