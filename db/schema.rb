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

ActiveRecord::Schema.define(version: 20160824182620) do

  create_table "inventories", force: :cascade do |t|
    t.integer  "survivor_id", limit: 4
    t.integer  "resource_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "inventories", ["resource_id"], name: "index_inventories_on_resource_id", using: :btree
  add_index "inventories", ["survivor_id"], name: "index_inventories_on_survivor_id", using: :btree

  create_table "last_locations", force: :cascade do |t|
    t.float    "latitude",    limit: 24
    t.float    "longitude",   limit: 24
    t.integer  "survivor_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "last_locations", ["survivor_id"], name: "index_last_locations_on_survivor_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "points",      limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "survivors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "age",        limit: 4
    t.string   "gender",     limit: 255
    t.boolean  "infected",               default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_foreign_key "inventories", "resources"
  add_foreign_key "inventories", "survivors"
  add_foreign_key "last_locations", "survivors"
end
