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


ActiveRecord::Schema.define(:version => 20140712192232) do

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

  create_table "badges_sashes", :force => true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", :default => false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], :name => "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], :name => "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], :name => "index_badges_sashes_on_sash_id"

  create_table "factual_crowdscore_maps", :force => true do |t|
    t.integer  "factual_category_id"
    t.integer  "venue_subcategory_id"
    t.text     "description"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "venue_category_id"
  end

  add_index "factual_crowdscore_maps", ["factual_category_id", "venue_subcategory_id"], :name => "index_factual_crowdscore_maps_on_ids", :unique => true

  create_table "follows", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "follows", ["followed_id"], :name => "index_follows_on_followed_id"
  add_index "follows", ["follower_id"], :name => "index_follows_on_follower_id"

  create_table "list_likes", :force => true do |t|
    t.integer  "list_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "description"
    t.integer  "list_likes_count", :default => 0
  end

  add_index "lists", ["user_id"], :name => "index_lists_on_user_id"

  create_table "lists_venues", :id => false, :force => true do |t|
    t.integer "list_id"
    t.integer "venue_id"
  end

  add_index "lists_venues", ["list_id"], :name => "index_lists_venues_on_list_id"
  add_index "lists_venues", ["venue_id"], :name => "index_lists_venues_on_venue_id"

  create_table "merit_actions", :force => true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    :default => false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "merit_activity_logs", :force => true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", :force => true do |t|
    t.integer  "score_id"
    t.integer  "num_points", :default => 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", :force => true do |t|
    t.integer "sash_id"
    t.string  "category", :default => "default"
  end

  create_table "sashes", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "score_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
<<<<<<< HEAD
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
=======
    t.integer  "venue_subcategory_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
>>>>>>> master
  end

  create_table "score_categories_venue_categories", :id => false, :force => true do |t|
    t.integer "score_category_id"
    t.integer "venue_category_id"
  end

  add_index "score_categories_venue_categories", ["score_category_id"], :name => "index_score_categories_venue_categories_on_score_category_id"
  add_index "score_categories_venue_categories", ["venue_category_id"], :name => "index_score_categories_venue_categories_on_venue_category_id"

  create_table "score_categories_venue_subcategories", :id => false, :force => true do |t|
    t.integer "score_category_id"
    t.integer "venue_subcategory_id"
  end

  add_index "score_categories_venue_subcategories", ["score_category_id"], :name => "index_score_categories_venue_subcategories_on_score_category_id"
  add_index "score_categories_venue_subcategories", ["venue_subcategory_id"], :name => "index_score_cats_venue_subcats_on_venue_subcategory_id"

  create_table "scores", :force => true do |t|
    t.integer  "score_category_id"
    t.integer  "value"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "venue_score_id"
    t.integer  "user_id"
    t.integer  "venue_id"
  end

  create_table "tags", :force => true do |t|
    t.integer  "tag_category_id"
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "venue_category_tag_set_id"
    t.integer  "venue_subcategory_tag_set_id"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["tag_category_id"], :name => "index_tags_on_tag_category_id"

  create_table "tags_venues", :id => false, :force => true do |t|
    t.integer "tag_id"
    t.integer "venue_id"
  end

  add_index "tags_venues", ["tag_id"], :name => "index_tags_venues_on_tag_id"
  add_index "tags_venues", ["venue_id"], :name => "index_tags_venues_on_venue_id"

  create_table "tip_likes", :force => true do |t|
    t.integer  "tip_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tip_likes", ["tip_id"], :name => "index_tip_likes_on_tip_id"
  add_index "tip_likes", ["user_id"], :name => "index_tip_likes_on_user_id"

  create_table "tips", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.string   "text"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "tip_likes_count", :default => 0
  end

  add_index "tips", ["user_id"], :name => "index_tips_on_user_id"
  add_index "tips", ["venue_id"], :name => "index_tips_on_venue_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",                    :default => ""
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
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "birth_month"
    t.integer  "birth_day"
    t.boolean  "admin",                                 :default => false
    t.string   "username"
    t.string   "zip_code"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "lock_reason"
    t.string   "gender"
    t.string   "facebook_id"
    t.string   "bio"
    t.string   "twitter_username"
    t.string   "permalink"
    t.integer  "sash_id"
    t.integer  "level",                                 :default => 0
    t.string   "invitation_token",        :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "home_state"
    t.string   "home_city"
    t.boolean  "receive_follower_emails",               :default => true
    t.boolean  "receive_product_emails",                :default => true
    t.text     "liked_venue_categories"
    t.string   "image_url"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id"
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "venue_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "prompt1"
    t.string   "prompt2"
    t.string   "prompt3"
    t.string   "prompt4"
    t.integer  "factual_category_id"
  end

  create_table "venue_category_tag_sets", :force => true do |t|
    t.integer  "venue_category_id"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "venue_images", :force => true do |t|
    t.string   "image_file"
    t.string   "caption"
    t.integer  "venue_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
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
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "venue_scores", ["user_id"], :name => "index_venue_scores_on_user_id"
  add_index "venue_scores", ["venue_id"], :name => "index_venue_scores_on_venue_id"

  create_table "venue_snapshots", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "venue_score_count"
    t.integer  "tip_count"
    t.integer  "current_crowdscore"
    t.integer  "score_breakdown1"
    t.integer  "score_breakdown2"
    t.integer  "score_breakdown3"
    t.integer  "score_breakdown4"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "venue_subcategories", :force => true do |t|
    t.integer  "venue_category_id"
    t.string   "name"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "factual_category_id"
  end

  add_index "venue_subcategories", ["venue_category_id"], :name => "index_venue_subcategories_on_venue_category_id"

  create_table "venue_subcategory_tag_sets", :force => true do |t|
    t.integer  "venue_subcategory_id"
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "venue_category_id"
    t.string   "url"
    t.integer  "venue_subcategory_id"
    t.boolean  "active",               :default => true
    t.integer  "computed_score"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "factual_id"
    t.string   "country"
    t.text     "hours"
    t.text     "neighborhoods"
    t.integer  "factual_category_id"
    t.text     "hour_ranges"
    t.text     "hours_with_names"
  end

  add_index "venues", ["venue_category_id"], :name => "index_venues_on_venue_category_id"
  add_index "venues", ["venue_subcategory_id"], :name => "index_venues_on_venue_subcategory_id"

end
