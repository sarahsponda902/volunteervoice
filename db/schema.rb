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

ActiveRecord::Schema.define(:version => 20121118042723) do

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.string   "name"
    t.string   "site_url"
    t.string   "email"
    t.text     "body"
    t.datetime "created_at"
  end

  add_index "blog_comments", ["blog_post_id"], :name => "index_blog_comments_on_blog_post_id"

  create_table "blog_images", :force => true do |t|
    t.integer  "blog_post_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
  end

  add_index "blog_images", ["blog_post_id"], :name => "index_blog_images_on_blog_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "published_at"
    t.string   "blog_link"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_x2"
    t.integer  "crop_y2"
    t.string   "square_image_file_name"
    t.string   "square_image_content_type"
    t.integer  "square_image_file_size"
    t.datetime "square_image_updated_at"
    t.boolean  "is_our_blog"
    t.boolean  "blog_type"
    t.integer  "crop_h"
    t.integer  "crop_w"
    t.boolean  "thumbnail"
    t.string   "source_title"
    t.string   "source"
    t.string   "image"
    t.string   "square_image"
    t.text     "truncated125"
    t.text     "truncated100"
  end

  create_table "blog_tags", :force => true do |t|
    t.integer "blog_post_id"
    t.string  "tag",          :null => false
    t.boolean "is_our_blog"
  end

  add_index "blog_tags", ["blog_post_id"], :name => "index_blog_tags_on_blog_post_id"
  add_index "blog_tags", ["tag"], :name => "index_blog_tags_on_tag"

  create_table "contacts", :force => true do |t|
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "name"
    t.string   "email"
    t.text     "body"
    t.string   "to_whom"
    t.string   "subject"
    t.integer  "user_id"
    t.integer  "organization_account_id"
    t.string   "organization_name"
    t.string   "country"
    t.string   "organization_url"
    t.string   "has_profile"
    t.string   "main_contact"
    t.string   "position_of_contact"
    t.string   "contact_email"
    t.boolean  "is_request"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "favorites", :force => true do |t|
    t.integer "user_id"
    t.integer "program_id"
  end

  create_table "feedbacks", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "show",         :default => false
    t.string   "email"
    t.text     "truncated100"
    t.boolean  "admin_read",   :default => false
  end

  create_table "flags", :force => true do |t|
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "body"
    t.integer  "poster_id"
    t.integer  "flagger_id"
    t.integer  "review_id"
    t.string   "category"
    t.boolean  "admin_read", :default => false
  end

  create_table "mad_mimi_emails", :force => true do |t|
    t.string   "subject"
    t.string   "from"
    t.string   "promotion_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "username"
    t.string   "api_key"
    t.string   "bcc"
    t.text     "list_names"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.boolean  "recipient_deleted", :default => false
    t.datetime "read_at"
    t.boolean  "sender_deleted",    :default => false
    t.text     "body"
  end

  create_table "new_reviews", :force => true do |t|
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "body"
    t.integer  "user_id"
    t.boolean  "before"
    t.boolean  "terms"
    t.decimal  "preparation"
    t.decimal  "support"
    t.decimal  "impact"
    t.decimal  "structure"
    t.decimal  "overall"
    t.string   "organization"
    t.string   "program"
    t.string   "time_frame"
    t.string   "photo"
    t.text     "truncated100"
    t.string   "photo2"
    t.string   "photo3"
    t.string   "photo4"
    t.string   "photo5"
    t.string   "photo6"
    t.string   "photo7"
    t.string   "photo8"
    t.string   "photo9"
    t.string   "photo10"
    t.boolean  "admin_read",   :default => false
  end

  create_table "organization_accounts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "type_of_company"
    t.boolean  "nonprofit"
    t.string   "username"
    t.boolean  "notify"
    t.string   "country"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "organization_id"
    t.string   "organization_name"
    t.string   "admin_pass"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "email_confirmation"
  end

  add_index "organization_accounts", ["email"], :name => "index_organization_accounts_on_email", :unique => true
  add_index "organization_accounts", ["invitation_token"], :name => "index_organization_accounts_on_invitation_token"
  add_index "organization_accounts", ["invited_by_id"], :name => "index_organization_accounts_on_invited_by_id"
  add_index "organization_accounts", ["reset_password_token"], :name => "index_organization_accounts_on_reset_password_token", :unique => true

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.integer  "program_id"
    t.boolean  "show",                         :default => false
    t.integer  "page_views"
    t.decimal  "overall"
    t.integer  "num_reviews"
    t.string   "email"
    t.integer  "operating_since"
    t.text     "good_to_know"
    t.integer  "reviews_count"
    t.text     "training_resources"
    t.string   "url"
    t.text     "volunteer_program_model"
    t.string   "image"
    t.string   "id_number"
    t.string   "square_image"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.string   "phone"
    t.text     "truncated75"
    t.text     "misson"
    t.text     "program_costs_includes"
    t.string   "program_model_string"
    t.string   "business_model"
    t.string   "run_by"
    t.string   "price_ranges"
    t.text     "program_costs_doesnt_include"
    t.text     "headquarters_location"
    t.string   "types_of_programs"
    t.string   "invite_email"
    t.boolean  "will_invite"
    t.boolean  "published_docs"
    t.string   "additional_fees"
    t.integer  "full_time_staff"
    t.string   "num_vols_yr"
    t.string   "num_vols_date"
    t.text     "application_process"
    t.text     "price_breakdown"
    t.boolean  "crops"
    t.datetime "reviewed_at",                                     :null => false
  end

  create_table "pages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "program_cost_length_maps", :force => true do |t|
    t.integer  "program_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.string   "length_name"
    t.integer  "length_number"
    t.float    "cost"
    t.float    "length"
  end

  create_table "program_sizes", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "program_id"
    t.string   "size"
    t.integer  "organization_id"
  end

  create_table "program_subjects", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "program_id"
    t.string   "subject"
    t.integer  "organization_id"
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "weekly_cost"
    t.string   "location"
    t.integer  "organization_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "review_id"
    t.string   "subject"
    t.string   "headquarters"
    t.decimal  "overall"
    t.string   "start_dates"
    t.text     "program_structure"
    t.string   "partnered_local_organizations"
    t.text     "cost_includes"
    t.text     "program_cost_breakdown"
    t.string   "check_it_out"
    t.string   "length"
    t.string   "group_size"
    t.string   "photo"
    t.string   "organization_name"
    t.string   "square_image"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.string   "chart"
    t.text     "truncated_description100"
    t.string   "program_started"
    t.text     "cost_doesnt_include"
    t.string   "url"
    t.string   "specific_location"
    t.string   "location_name"
    t.boolean  "published_docs"
    t.string   "lengths_of_program"
    t.string   "food_situation"
    t.string   "program_requirements"
    t.text     "accommodations"
  end

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.integer  "program_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "user_id"
    t.boolean  "show",              :default => false
    t.integer  "organization_id"
    t.boolean  "before"
    t.boolean  "terms"
    t.decimal  "preparation"
    t.decimal  "support"
    t.decimal  "impact"
    t.decimal  "structure"
    t.decimal  "overall"
    t.string   "time_frame"
    t.string   "photo"
    t.string   "organization_name"
    t.string   "photo2"
    t.string   "photo3"
    t.string   "photo4"
    t.string   "photo5"
    t.string   "photo6"
    t.string   "photo7"
    t.string   "photo8"
    t.string   "photo9"
    t.string   "photo10"
    t.text     "truncated100"
    t.text     "truncated200"
    t.boolean  "flag_show",         :default => true
    t.boolean  "admin_read",        :default => false
  end

  create_table "searches", :force => true do |t|
    t.text     "regions"
    t.text     "subjects"
    t.text     "sizes"
    t.integer  "price_min"
    t.integer  "price_max"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "showing"
    t.string   "sort_by"
    t.string   "keywords"
    t.string   "sent_from"
    t.integer  "length_min_number"
    t.string   "length_min_param"
    t.integer  "length_max_number"
    t.string   "length_max_param"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "supports", :force => true do |t|
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                     :default => "",    :null => false
    t.string   "encrypted_password",        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "username"
    t.integer  "age"
    t.string   "country"
    t.boolean  "admin",                     :default => false
    t.string   "validate_user_email"
    t.string   "validate_user_name"
    t.datetime "dob"
    t.boolean  "notify",                    :default => true
    t.boolean  "verify"
    t.integer  "crop_x"
    t.integer  "crop_y"
    t.integer  "crop_w"
    t.integer  "crop_h"
    t.string   "square_photo_content_type"
    t.boolean  "approved",                  :default => false, :null => false
    t.boolean  "volunteered_before"
    t.string   "admin_pass"
    t.boolean  "admin_update"
    t.boolean  "profile_show",              :default => false
    t.boolean  "messages_show",             :default => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "photo"
    t.integer  "failed_attempts",           :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "square_image"
    t.boolean  "cropping"
    t.boolean  "crops"
    t.integer  "unread_messages",           :default => 0
    t.string   "return_link"
    t.boolean  "admin_read",                :default => false
  end

  add_index "users", ["approved"], :name => "index_users_on_approved"
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
