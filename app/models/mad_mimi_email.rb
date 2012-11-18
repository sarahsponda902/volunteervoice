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
  [[User, :notify], [User, :admin], [OrganizationAccount, :notify]].each do |klass, column|
    define_method "get_list_names" do
      klass.where(column => true).map {|resource| [resource.email, {"username" => resource.username, 
        "firstname" => resource.first_name || nil, 
        "lastname" => resource.last_name || nil, 
        "unsubscribe_link" => "volunteervoice.org/#{klass.underscore}s/#{resource.id}/change_subscription",
        'position' => resource.position || nil, 
        'email' => resource.email,'country' => resource.country, 
        'organization_name' => resource.name || nil}]}
    end
  end
end
