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

ActiveRecord::Schema.define(:version => 20130426091346) do

  create_table "addresses", :force => true do |t|
    t.integer  "member_id"
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "postal_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "attachments", :force => true do |t|
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "song_id"
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "family_member_roles", :force => true do |t|
    t.integer  "family_role_id"
    t.integer  "family_member_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "family_member_roles", ["family_member_id"], :name => "index_family_member_roles_on_family_member_id"
  add_index "family_member_roles", ["family_role_id"], :name => "index_family_member_roles_on_family_role_id"

  create_table "family_members", :force => true do |t|
    t.integer  "member_id"
    t.integer  "family_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "family_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "email"
    t.date     "date_of_birth"
    t.date     "joined_on"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "relationship_status"
    t.string   "employment_status"
    t.string   "cell_group"
    t.string   "preferred_service"
    t.boolean  "accept_communication"
  end

  create_table "message_attachments", :force => true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "message_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.string   "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "permissions", ["key"], :name => "index_permissions_on_key", :unique => true

  create_table "phone_numbers", :force => true do |t|
    t.integer  "member_id"
    t.string   "name"
    t.string   "dialing_code"
    t.string   "number"
    t.string   "mobile"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "role_permissions", :force => true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sermons", :force => true do |t|
    t.string   "name"
    t.string   "series"
    t.string   "preacher"
    t.date     "date"
    t.integer  "duration"
    t.string   "url"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "play_count", :default => 0
  end

  create_table "song_sets", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.date     "play_on"
    t.boolean  "published"
    t.boolean  "processed",  :default => false
    t.text     "message"
  end

  create_table "song_sets_songs", :force => true do |t|
    t.integer "song_set_id"
    t.integer "song_id"
    t.integer "position_number"
    t.string  "lead_by"
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "audio"
    t.string   "sheet_music"
    t.integer  "latest_mp3_id"
    t.integer  "latest_sheet_music_id"
    t.date     "last_played_on"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                        :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.boolean  "worship_leader"
  end

  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

end
