# == Schema Information
#
# Table name: mad_mimi_emails
#
#  id             :integer          not null, primary key
#  subject        :string(255)
#  from           :string(255)
#  promotion_name :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  username       :string(255)
#  api_key        :string(255)
#  bcc            :string(255)
#  list_names     :text
#

class MadMimiEmail < ActiveRecord::Base  
end
