# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  email                     :string(255)      default(""), not null
#  encrypted_password        :string(255)      default(""), not null
#  reset_password_token      :string(255)
#  reset_password_sent_at    :datetime
#  remember_created_at       :datetime
#  sign_in_count             :integer          default(0)
#  current_sign_in_at        :datetime
#  last_sign_in_at           :datetime
#  current_sign_in_ip        :string(255)
#  last_sign_in_ip           :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  username                  :string(255)
#  age                       :integer
#  country                   :string(255)
#  admin                     :boolean          default(FALSE)
#  validate_user_email       :string(255)
#  validate_user_name        :string(255)
#  dob                       :datetime
#  notify                    :boolean          default(TRUE)
#  verify                    :boolean
#  crop_x                    :integer
#  crop_y                    :integer
#  crop_w                    :integer
#  crop_h                    :integer
#  square_photo_content_type :string(255)
#  approved                  :boolean          default(FALSE), not null
#  volunteered_before        :boolean
#  admin_pass                :string(255)
#  admin_update              :boolean
#  profile_show              :boolean          default(TRUE)
#  messages_show             :boolean
#  confirmation_token        :string(255)
#  confirmed_at              :datetime
#  confirmation_sent_at      :datetime
#  unconfirmed_email         :string(255)
#  photo                     :string(255)
#  failed_attempts           :integer          default(0)
#  unlock_token              :string(255)
#  locked_at                 :datetime
#  square_image              :string(255)
#  cropping                  :boolean
#  crops                     :boolean
#  unread_messages           :integer
#  return_link               :string(255)
#  admin_read                :boolean          default(FALSE)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
