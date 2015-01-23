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

ActiveRecord::Schema.define(version: 20150119173526) do

  create_table "Elements", force: true do |t|
    t.string   "value"
    t.text     "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "tags"
  end

  create_table "feeds", force: true do |t|
    t.string   "name"
    t.text     "last_updated"
    t.text     "next_run"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
    t.text     "tags"
  end

  create_table "feeds_tags", id: false, force: true do |t|
    t.integer "feed_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "feeds_tags", ["feed_id", "tag_id"], name: "index_feeds_tags_on_feed_id_and_tag_id"
  add_index "feeds_tags", ["tag_id", "feed_id"], name: "index_feeds_tags_on_tag_id_and_feed_id"

  create_table "samples", force: true do |t|
    t.string   "filename"
    t.string   "sha256"
    t.string   "sha1sum"
    t.string   "md5sum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "malz_file_name"
    t.string   "malz_content_type"
    t.integer  "malz_file_size"
    t.datetime "malz_updated_at"
    t.text     "detection"
  end

  create_table "tags", force: true do |t|
    t.string   "tagname"
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
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "whois", force: true do |t|
    t.string   "country"
    t.string   "state"
    t.string   "asn"
    t.text     "registrant"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
