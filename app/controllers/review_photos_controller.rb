class ReviewPhotosController < ApplicationController
  def index
      @review_photos = ReviewPhoto.all
      render :json => @review_photos.collect { |p| p.to_jq_upload }.to_json
    end

    def create
      @review_photo = ReviewPhoto.new(params[:review_photo])
      @review_photo.save

    end

    def destroy
      @review_photo = ReviewPhoto.find(params[:id])
      @review_photo.destroy
      render :json => true
    end
  
  
  
end
