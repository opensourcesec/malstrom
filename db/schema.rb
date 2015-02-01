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

ActiveRecord::Schema.define(version: 20150201052512) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "elements", force: true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "kind"
  end

  create_table "feeds", force: true do |t|
    t.string   "name"
    t.text     "last_updated"
    t.text     "next_run"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "url"
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

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

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
