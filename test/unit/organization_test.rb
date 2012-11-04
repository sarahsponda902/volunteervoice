# == Schema Information
#
# Table name: organizations
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  description                  :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  program_id                   :integer
#  show                         :boolean
#  page_views                   :integer
#  overall                      :decimal(, )
#  num_reviews                  :integer
#  email                        :string(255)
#  operating_since              :integer
#  good_to_know                 :text
#  reviews_count                :integer
#  training_resources           :text
#  url                          :string(255)
#  volunteer_program_model      :text
#  image                        :string(255)
#  id_number                    :string(255)
#  square_image                 :string(255)
#  crop_x                       :integer
#  crop_y                       :integer
#  crop_w                       :integer
#  crop_h                       :integer
#  phone                        :string(255)
#  truncated75                  :text
#  misson                       :text
#  program_costs_includes       :text
#  program_model_string         :string(255)
#  business_model               :string(255)
#  run_by                       :string(255)
#  price_ranges                 :string(255)
#  program_costs_doesnt_include :text
#  headquarters_location        :text
#  types_of_programs            :string(255)
#  invite_email                 :string(255)
#  will_invite                  :boolean
#  published_docs               :boolean
#  additional_fees              :string(255)
#  full_time_staff              :integer
#  num_vols_yr                  :string(255)
#  num_vols_date                :string(255)
#  application_process          :text
#  price_breakdown              :text
#  crops                        :boolean
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
