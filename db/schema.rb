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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111020055511) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "tips", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tips", ["user_id"], :name => "index_tips_on_user_id"
  add_index "tips", ["venue_id"], :name => "index_tips_on_venue_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "birth_month"
    t.integer  "birth_day"
    t.string   "unconfirmed_email"
    t.boolean  "admin",                                 :default => false
    t.string   "username"
    t.string   "zip_code"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "lock_reason"
    t.string   "gender"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "venue_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prompt1"
    t.string   "prompt2"
    t.string   "prompt3"
    t.string   "prompt4"
  end

  create_table "venue_images", :force => true do |t|
    t.string   "image_file"
    t.string   "caption"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_images", ["venue_id"], :name => "index_venue_images_on_venue_id"

  create_table "venue_scores", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.integer  "computed_score"
    t.integer  "score1"
    t.integer  "score2"
    t.integer  "score3"
    t.integer  "score4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_scores", ["user_id"], :name => "index_venue_scores_on_user_id"
  add_index "venue_scores", ["venue_id"], :name => "index_venue_scores_on_venue_id"

  create_table "venue_subcategories", :force => true do |t|
    t.integer  "venue_category_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_subcategories", ["venue_category_id"], :name => "index_venue_subcategories_on_venue_category_id"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "venue_category_id"
    t.string   "url"
    t.integer  "venue_subcategory_id"
    t.boolean  "active",               :default => true
    t.integer  "computed_score"
  end

  add_index "venues", ["venue_category_id"], :name => "index_venues_on_venue_category_id"
  add_index "venues", ["venue_subcategory_id"], :name => "index_venues_on_venue_subcategory_id"

end
