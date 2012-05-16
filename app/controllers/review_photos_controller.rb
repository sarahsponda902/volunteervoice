class ReviewPhotosController < ApplicationController
  def index
      @review_photos = ReviewPhoto.all
      render :json => @review_photos.collect { |p| p.to_jq_upload }.to_json
    end

    def create
      @review_photo = ReviewPhoto.new(params[:review_photo])
      if @review_photo.save
        respond_to do |format|
          format.html {  
            render :json => [@review_photo.to_jq_upload].to_json, 
            :content_type => 'text/html',
            :layout => false
          }
          format.json {  
            render :json => [@review_photo.to_jq_upload].to_json			
          }
        end
      else 
        render :json => [{:error => "custom_failure"}], :status => 304
      end
    end

    def destroy
      @review_photo = ReviewPhoto.find(params[:id])
      @review_photo.destroy
      render :json => true
    end
  
  
  
end
