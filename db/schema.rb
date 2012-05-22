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

ActiveRecord::Schema.define(:version => 20120522070048) do

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

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "copy_sender"
  end

  create_table "contests", :force => true do |t|
    t.string   "name"
    t.time     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "entries", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "active",            :default => false, :null => false
    t.string   "artist_type"
    t.string   "community_name"
    t.string   "audition_type"
    t.string   "song_title"
    t.string   "written_by"
    t.string   "performance_video"
    t.string   "gift_name"
    t.string   "gift_description"
    t.string   "gift_value"
    t.string   "kickstarter"
    t.string   "pledgemusic"
    t.string   "youtube_url"
    t.string   "genre"
    t.string   "source"
  end

  add_index "entries", ["contest_id"], :name => "index_entries_on_contest_id"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "judgings", :force => true do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "active",     :default => false, :null => false
    t.string   "genres"
  end

  add_index "judgings", ["contest_id"], :name => "index_judgings_on_contest_id"
  add_index "judgings", ["user_id"], :name => "index_judgings_on_user_id"

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip"
    t.string   "country"
    t.boolean  "interview_status"
    t.string   "profile_name"
    t.string   "hometown"
    t.string   "bio"
    t.string   "profile_video"
    t.string   "performance_video"
    t.string   "profile_photo_square"
    t.string   "profile_photo_landscape"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "phone"
    t.string   "youtube"
    t.string   "genre"
    t.boolean  "admin",                   :default => false, :null => false
    t.string   "gender"
    t.string   "birth_year"
    t.integer  "thumb_x"
    t.integer  "thumb_y"
    t.integer  "thumb_w"
    t.string   "youtube_url"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
