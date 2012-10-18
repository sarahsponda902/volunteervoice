# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# encoding: utf-8


# encoding: utf-8

Admin.create([
  { :email => "", :encrypted_password => "", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil }
], :without_protection => true )



BlogComment.create([
  { :blog_post_id => nil, :user_id => nil, :user_ip => nil, :user_agent => nil, :referrer => nil, :name => nil, :site_url => nil, :email => nil, :body => nil, :created_at => nil }
], :without_protection => true )



BlogImage.create([
  { :blog_post_id => nil, :created_at => nil, :updated_at => nil, :image => nil }
], :without_protection => true )



BlogPost.create([
  { :title => nil, :body => nil, :created_at => nil, :updated_at => nil, :published => nil, :user_id => nil, :published_at => nil, :blog_link => nil, :crop_x => nil, :crop_y => nil, :crop_x2 => nil, :crop_y2 => nil, :square_image_file_name => nil, :square_image_content_type => nil, :square_image_file_size => nil, :square_image_updated_at => nil, :is_our_blog => nil, :blog_type => nil, :crop_h => nil, :crop_w => nil, :thumbnail => nil, :source_title => nil, :source => nil, :image => nil, :square_image => nil, :truncated125 => nil, :truncated100 => nil }
], :without_protection => true )



BlogTag.create([
  { :blog_post_id => nil, :tag => nil, :is_our_blog => nil }
], :without_protection => true )



Contact.create([
  { :created_at => nil, :updated_at => nil, :name => nil, :email => nil, :body => nil, :to_whom => nil, :subject => nil, :user_id => nil, :organization_account_id => nil, :organization_name => nil, :country => nil, :organization_url => nil, :has_profile => nil, :main_contact => nil, :position_of_contact => nil, :contact_email => nil, :is_request => nil }
], :without_protection => true )



Favorite.create([
  { :user_id => nil, :program_id => nil }
], :without_protection => true )



Feedback.create([
  { :body => nil, :user_id => nil, :created_at => nil, :updated_at => nil, :show => nil, :email => nil, :truncated100 => nil, :admin_read => false }
], :without_protection => true )



Flag.create([
  { :created_at => nil, :updated_at => nil, :body => nil, :poster_id => nil, :flagger_id => nil, :review_id => nil, :category => nil, :admin_read => false }
], :without_protection => true )



MadMimiEmail.create([
  { :subject => nil, :from => nil, :promotion_name => nil, :created_at => nil, :updated_at => nil, :username => nil, :api_key => nil, :bcc => nil, :list_names => nil }
], :without_protection => true )



Message.create([
  { :subject => nil, :sender_id => nil, :recipient_id => nil, :created_at => nil, :updated_at => nil, :recipient_deleted => false, :read_at => nil, :sender_deleted => nil, :body => nil }
], :without_protection => true )



NewReview.create([
  { :created_at => nil, :updated_at => nil, :body => nil, :user_id => nil, :before => nil, :terms => nil, :preparation => nil, :support => nil, :impact => nil, :structure => nil, :overall => nil, :organization => nil, :program => nil, :time_frame => nil, :photo => nil, :truncated100 => nil, :photo2 => nil, :photo3 => nil, :photo4 => nil, :photo5 => nil, :photo6 => nil, :photo7 => nil, :photo8 => nil, :photo9 => nil, :photo10 => nil, :admin_read => false }
], :without_protection => true )



Organization.create([
  { :name => nil, :description => nil, :created_at => nil, :updated_at => nil, :program_id => nil, :show => nil, :page_views => nil, :overall => nil, :num_reviews => nil, :email => nil, :operating_since => nil, :good_to_know => nil, :reviews_count => nil, :training_resources => nil, :url => nil, :volunteer_program_model => nil, :image => nil, :id_number => nil, :square_image => nil, :crop_x => nil, :crop_y => nil, :crop_w => nil, :crop_h => nil, :phone => nil, :truncated75 => nil, :misson => nil, :program_costs_includes => nil, :program_model_string => nil, :business_model => nil, :run_by => nil, :price_ranges => nil, :program_costs_doesnt_include => nil, :headquarters_location => nil, :types_of_programs => nil, :invite_email => nil, :will_invite => nil, :published_docs => nil, :additional_fees => nil, :full_time_staff => nil, :num_vols_yr => nil, :num_vols_date => nil, :application_process => nil, :price_breakdown => nil, :crops => nil }
], :without_protection => true )



OrganizationAccount.create([
  { :first_name => nil, :last_name => nil, :position => nil, :type_of_company => nil, :nonprofit => nil, :username => nil, :notify => nil, :country => nil, :created_at => nil, :updated_at => nil, :email => "", :encrypted_password => "", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :invitation_token => nil, :invitation_sent_at => nil, :invitation_accepted_at => nil, :invitation_limit => nil, :invited_by_id => nil, :invited_by_type => nil, :organization_id => nil, :organization_name => nil, :admin_pass => nil, :failed_attempts => 0, :unlock_token => nil, :locked_at => nil, :email_confirmation => nil }
], :without_protection => true )



Page.create([
  { :created_at => nil, :updated_at => nil }
], :without_protection => true )



Program.create([
  { :name => nil, :description => nil, :weekly_cost => nil, :location => nil, :organization_id => nil, :created_at => nil, :updated_at => nil, :review_id => nil, :subject => nil, :headquarters => nil, :overall => nil, :start_dates => nil, :program_structure => nil, :partnered_local_organizations => nil, :cost_includes => nil, :program_cost_breakdown => nil, :check_it_out => nil, :length => nil, :group_size => nil, :photo => nil, :organization_name => nil, :square_image => nil, :crop_x => nil, :crop_y => nil, :crop_w => nil, :crop_h => nil, :chart => nil, :truncated_description100 => nil, :program_started => nil, :cost_doesnt_include => nil, :url => nil, :specific_location => nil, :location_name => nil, :published_docs => nil, :lengths_of_program => nil, :food_situation => nil, :program_requirements => nil, :accommodations => nil }
], :without_protection => true )



ProgramCostLengthMap.create([
  { :program_id => nil, :created_at => nil, :updated_at => nil, :organization_id => nil, :length_name => nil, :length_number => nil, :cost => nil, :length => nil }
], :without_protection => true )



ProgramSize.create([
  { :created_at => nil, :updated_at => nil, :program_id => nil, :size => nil, :organization_id => nil }
], :without_protection => true )



ProgramSubject.create([
  { :created_at => nil, :updated_at => nil, :program_id => nil, :subject => nil, :organization_id => nil }
], :without_protection => true )



Review.create([
  { :body => nil, :program_id => nil, :created_at => nil, :updated_at => nil, :user_id => nil, :show => nil, :organization_id => nil, :before => nil, :terms => nil, :preparation => nil, :support => nil, :impact => nil, :structure => nil, :overall => nil, :time_frame => nil, :photo => nil, :organization_name => nil, :photo2 => nil, :photo3 => nil, :photo4 => nil, :photo5 => nil, :photo6 => nil, :photo7 => nil, :photo8 => nil, :photo9 => nil, :photo10 => nil, :truncated100 => nil, :truncated200 => nil, :flag_show => nil, :admin_read => false }
], :without_protection => true )



Search.create([
  { :regions => nil, :subjects => nil, :sizes => nil, :price_min => 0, :price_max => 99999, :created_at => "2012-09-08 00:37:37", :updated_at => "2012-09-08 00:37:37", :showing => nil, :sort_by => nil, :keywords => nil, :sent_from => nil, :length_min_number => 0, :length_min_param => "weeks", :length_max_number => 2, :length_max_param => "years" }
], :without_protection => true )



User.create([
  { :email => "", :encrypted_password => "", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :created_at => nil, :updated_at => nil, :username => nil, :age => nil, :country => nil, :admin => false, :validate_user_email => nil, :validate_user_name => nil, :dob => nil, :notify => true, :verify => nil, :crop_x => nil, :crop_y => nil, :crop_w => nil, :crop_h => nil, :square_photo_content_type => nil, :approved => false, :volunteered_before => nil, :admin_pass => nil, :admin_update => nil, :profile_show => true, :messages_show => nil, :confirmation_token => nil, :confirmed_at => nil, :confirmation_sent_at => nil, :unconfirmed_email => nil, :photo => nil, :failed_attempts => 0, :unlock_token => nil, :locked_at => nil, :square_image => nil, :cropping => nil, :crops => nil, :unread_messages => nil, :return_link => nil, :admin_read => false }
], :without_protection => true )


