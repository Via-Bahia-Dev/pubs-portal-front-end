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

ActiveRecord::Schema.define(version: 20160301184859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_tokens", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id"
    t.datetime "last_used_at"
    t.string   "ip_address"
    t.string   "user_agent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "authentication_tokens", ["user_id"], name: "index_authentication_tokens_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "publication_request_id"
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "publication_requests", force: :cascade do |t|
    t.string   "event"
    t.text     "description"
    t.string   "dimensions"
    t.datetime "rough_date"
    t.datetime "due_date"
    t.datetime "event_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "designer_id"
    t.integer  "admin_id"
    t.integer  "reviewer_id"
    t.integer  "template_id"
    t.integer  "status_id"
  end

  add_index "publication_requests", ["status_id"], name: "index_publication_requests_on_status_id", using: :btree

  create_table "request_attachments", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "publication_request_id"
    t.integer  "user_id"
    t.text     "comment"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "color"
    t.integer  "order"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "template_id"
    t.integer  "tag_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["template_id"], name: "index_taggings_on_template_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "dimensions"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "link"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "password_digest"
    t.integer  "roles_mask"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  add_foreign_key "authentication_tokens", "users"
  add_foreign_key "request_attachments", "publication_requests"
  add_foreign_key "request_attachments", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "templates"
end
