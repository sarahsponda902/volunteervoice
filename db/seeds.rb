# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# encoding: utf-8


# encoding: utf-8



Organization.create([
  { :name => "Testing123", :description => nil, :created_at => nil, :updated_at => nil, :program_id => nil, :show => nil, :page_views => nil, :overall => nil, :num_reviews => nil, :email => nil, :operating_since => nil, :good_to_know => nil, :reviews_count => nil, :training_resources => nil, :url => nil, :volunteer_program_model => nil, :image => nil, :id_number => nil, :square_image => nil, :crop_x => nil, :crop_y => nil, :crop_w => nil, :crop_h => nil, :phone => nil, :truncated75 => nil, :misson => nil, :program_costs_includes => nil, :program_model_string => nil, :business_model => nil, :run_by => nil, :price_ranges => nil, :program_costs_doesnt_include => nil, :headquarters_location => nil, :types_of_programs => nil, :invite_email => nil, :will_invite => nil, :published_docs => nil, :additional_fees => nil, :full_time_staff => nil, :num_vols_yr => nil, :num_vols_date => nil, :application_process => nil, :price_breakdown => nil, :crops => nil }
], :without_protection => true )


Program.create([
  { :name => nil, :description => nil, :weekly_cost => nil, :location => nil, :organization_id => nil, :created_at => nil, :updated_at => nil, :review_id => nil, :subject => nil, :headquarters => nil, :overall => nil, :start_dates => nil, :program_structure => nil, :partnered_local_organizations => nil, :cost_includes => nil, :program_cost_breakdown => nil, :check_it_out => nil, :length => nil, :group_size => nil, :photo => nil, :organization_name => nil, :square_image => nil, :crop_x => nil, :crop_y => nil, :crop_w => nil, :crop_h => nil, :chart => nil, :truncated_description100 => nil, :program_started => nil, :cost_doesnt_include => nil, :url => nil, :specific_location => nil, :location_name => nil, :published_docs => nil, :lengths_of_program => nil, :food_situation => nil, :program_requirements => nil, :accommodations => nil }
], :without_protection => true )



ProgramSubject.create([
  { :created_at => nil, :updated_at => nil, :program_id => nil, :subject => nil, :organization_id => nil }
], :without_protection => true )


