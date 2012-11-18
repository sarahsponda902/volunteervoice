class PagesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def home
    [Feedback, Organization, Review].each do |klass|
      instance_variable_set("@#{klass.name.to_s}s", klass.where(:show => true))
    end
    @show_reviews = @reviews.sort_by(&:created_at).reverse[0..2]
    @show_organizations = @organizations.shuffle[0..1]
    @show_feedbacks = @feedbacks.shuffle[0..2]
    @feedback = Feedback.new
  end

  [:test, :enable_js, :about, :terms, :privacy, :faq].each do |page|
    define_method page
  end
end
