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

ActiveRecord::Schema.define(version: 20140516092304) do

  create_table "courses", force: true do |t|
    t.string   "name",            null: false
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tutorials_count"
    t.string   "slug"
  end

  add_index "courses", ["slug"], name: "index_courses_on_slug", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_tutorials", force: true do |t|
    t.integer "tag_id"
    t.integer "tutorial_id"
  end

  create_table "tutorials", force: true do |t|
    t.integer  "course_id",    null: false
    t.string   "title",        null: false
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "videos_count"
  end

  add_index "tutorials", ["course_id"], name: "index_tutorials_on_course_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name",       null: false
    t.string   "email"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.integer  "tutorial_id", null: false
    t.string   "title",       null: false
    t.string   "description"
    t.string   "video_url",   null: false
    t.string   "image_url"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["tutorial_id"], name: "index_videos_on_tutorial_id", using: :btree

end
