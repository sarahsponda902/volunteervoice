class ErrorsController < ApplicationController
  # page rendered when 404 (called by application_controller)
  ### contact form is a popup for "if you are very confused"
  def error_404
  end

  # page rendered when 500 (called by application_controller)
  def error_500
  end

end
