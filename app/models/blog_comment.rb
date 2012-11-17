# == Schema Information
#
# Table name: blog_comments
#
#  id           :integer          not null, primary key
#  blog_post_id :integer
#  user_id      :integer
#  user_ip      :string(255)
#  user_agent   :string(255)
#  referrer     :string(255)
#  name         :string(255)
#  site_url     :string(255)
#  email        :string(255)
#  body         :text
#  created_at   :datetime
#

#######################################################################
### Written (mostly) Ryan Stout                                   #####
### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
#######################################################################

class BlogComment < ActiveRecord::Base
  include BlogKitModelHelper
  unloadable

  # associations #
  belongs_to :user
  belongs_to :blog_article

  # callbacks #
  before_save :check_for_spam
  before_save :redcloth_body
  profanity_filter :body
  validates_presence_of :body

  #### callback methods (again, part of blog_kit plugin) ####
  def validate
    if !self.user
      self.errors.add(:name, 'is required') if self.name.blank?
    end
  end

  def check_for_spam
    if BlogKit.instance.settings['akismet_key'] && BlogKit.instance.settings['blog_url']
      if Akismetor.spam?(akismet_attributes)
        self.errors.add_to_base('This comment has been detected as spam')
        return false
      else
        return true
      end
    end
    true
  end


  #### other methods ####

  def formatted_created_at
    self.created_at.strftime(BlogKit.instance.settings['post_date_format'] || '%m/%d/%Y at %I:%M%p')
  end

  def redcloth_body
    self.body = RedCloth.new( ActionController::Base.helpers.sanitize( self.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
  end

  def user_name
    name = self.user ? self.user.name : self.name
    if !self.site_url.blank?
      return "<a href=\"#{self.site_url}\">#{name}</a>"
    else
      return name
    end
  end

  # Used to set more tracking for akismet
  def request=(request)
    self.user_ip    = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.referrer   = request.env['HTTP_REFERER']
  end

  def akismet_attributes
    {
      :key                  => BlogKit.instance.settings['akismet_key'],
      :blog                 => BlogKit.instance.settings['blog_url'],
      :user_ip              => user_ip,
      :user_agent           => user_agent,
      :comment_author       => name,
      :comment_author_email => email,
      :comment_author_url   => site_url,
      :comment_content      => body
    }
  end


end
