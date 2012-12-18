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

ActiveRecord::Schema.define(:version => 20121218184619) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "contests", :force => true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.string   "stage_name"
    t.string   "title"
    t.string   "youtube_url"
    t.string   "genre"
    t.string   "hometown"
    t.text     "bio"
    t.string   "profile_photo"
    t.integer  "points",               :default => 0
    t.string   "facebook",             :default => "http://www.facebook.com/"
    t.string   "twitter",              :default => "http://www.twitter.com/"
    t.string   "youtube",              :default => "http://www.youtube.com/"
    t.string   "pinterest",            :default => "http://www.pinterest.com/"
    t.string   "website",              :default => "http://"
    t.boolean  "has_music",            :default => true
    t.boolean  "has_vocals",           :default => true
    t.boolean  "has_explicit_content", :default => false
    t.integer  "contest_id"
  end

  add_index "entries", ["contest_id"], :name => "index_entries_on_contest_id"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "evaluations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "entry_id"
    t.text     "comment"
    t.integer  "music_score"
    t.integer  "presentation_score"
    t.integer  "vocals_score"
    t.float    "overall_score"
  end

  add_index "evaluations", ["entry_id"], :name => "index_judgings_on_entry_id"
  add_index "evaluations", ["user_id"], :name => "index_judgings_on_user_id"

  create_table "follows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "follows", ["entry_id"], :name => "index_follows_on_entry_id"
  add_index "follows", ["user_id"], :name => "index_follows_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.string   "email",                   :default => "",    :null => false
    t.string   "encrypted_password",      :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
    t.string   "hometown"
    t.boolean  "admin",                   :default => false, :null => false
    t.boolean  "show_explicit_videos",    :default => true
    t.boolean  "receive_email_updates",   :default => true
    t.string   "profile_photo"
    t.string   "referral_token"
    t.string   "shortened_referral_link"
    t.integer  "inviter_id"
    t.boolean  "musician",                :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["inviter_id"], :name => "index_users_on_inviter_id"
  add_index "users", ["referral_token"], :name => "index_users_on_referral_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
