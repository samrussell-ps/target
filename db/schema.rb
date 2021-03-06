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

ActiveRecord::Schema.define(version: 20151105212645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.integer  "dictionary_word_id"
    t.integer  "word_shuffle_seed"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "centre_letter_offset"
  end

  create_table "dictionary_words", force: :cascade do |t|
    t.string   "word"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "sorted_letters"
  end

  add_index "dictionary_words", ["word"], name: "index_dictionary_words_on_word", using: :btree

  create_table "submitted_words", force: :cascade do |t|
    t.integer  "dictionary_word_id"
    t.integer  "board_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
