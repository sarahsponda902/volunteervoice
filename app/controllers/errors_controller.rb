class ErrorsController < ApplicationController
  def error_404
     @contact = Contact.new
  end

  def error_500
  end
  
  def error_searches
    @search = Search.new
  end
end
