class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    if (user_signed_in? && current_user.admin?)
    @feedbacks = Feedback.all.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  else 
    redirect_to root_path
  end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.truncated200 = RedCloth.new( sanitize( truncate(@feedback.body, :length => 200 ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @feedback.body = RedCloth.new( sanitize( @feedback.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    respond_to do |format|
      if @feedback.save
        format.html { redirect_to '/pages/thank_you', notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      else
        format.html { render action: "new" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    if (user_signed_in? && current_user.admin?)
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end
else
  redirect_to root_path
end

def changeShow
  if (user_signed_in? && current_user.admin?)
    @feedback = Feedback.find(params[:id])
    if @feedback.show
      @feedback.show = false
      @feedback.save
    else
      @feedback.show = true
      @feedback.save
    end
    respond_to do |format|
      format.html { redirect_to feedbacks_url }
    end
  else
    redirect_to root_path
  end
end

end
