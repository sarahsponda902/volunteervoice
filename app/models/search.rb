# == Schema Information
#
# Table name: searches
#
#  id                :integer          not null, primary key
#  regions           :text
#  subjects          :text
#  sizes             :text
#  price_min         :integer
#  price_max         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  showing           :string(255)
#  sort_by           :string(255)
#  keywords          :string(255)
#  sent_from         :string(255)
#  length_min_number :integer
#  length_min_param  :string(255)
#  length_max_number :integer
#  length_max_param  :string(255)
#

class Search < ActiveRecord::Base
end
