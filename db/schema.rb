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

ActiveRecord::Schema.define(version: 20160703080905) do

  create_table "comments", force: :cascade do |t|
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["item_id"], name: "index_comments_on_item_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "follow_tags", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "follow_tags", ["tag_id"], name: "index_follow_tags_on_tag_id", using: :btree
  add_index "follow_tags", ["user_id"], name: "index_follow_tags_on_user_id", using: :btree

  create_table "follow_users", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "follow_users", ["followed_id"], name: "index_follow_users_on_followed_id", using: :btree
  add_index "follow_users", ["follower_id", "followed_id"], name: "index_follow_users_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "follow_users", ["follower_id"], name: "index_follow_users_on_follower_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "stocks", ["item_id"], name: "index_stocks_on_item_id", using: :btree
  add_index "stocks", ["user_id"], name: "index_stocks_on_user_id", using: :btree

  create_table "tag_items", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.integer  "tag_id",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "tag_items", ["item_id"], name: "index_tag_items_on_item_id", using: :btree
  add_index "tag_items", ["tag_id"], name: "index_tag_items_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "comments", "items"
  add_foreign_key "comments", "users"
  add_foreign_key "follow_tags", "tags"
  add_foreign_key "follow_tags", "users"
  add_foreign_key "items", "users"
  add_foreign_key "stocks", "items"
  add_foreign_key "stocks", "users"
  add_foreign_key "tag_items", "items"
  add_foreign_key "tag_items", "tags"
end
