class NewReviewsController < ApplicationController
  # GET /new_reviews
  # GET /new_reviews.json
  def index
    if user_signed_in? && current_user.admin?
    @new_reviews = NewReview.all.reverse
    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @new_reviews }
    end
  else 
    redirect_to root_path
  end
  end

  # GET /new_reviews/1
  # GET /new_reviews/1.json
  def show
    if user_signed_in? && current_user.admin?
    @new_review = NewReview.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @new_review }
    end
  else
    redirect_to root_path
  end
  end

  # GET /new_reviews/new
  # GET /new_reviews/new.json
  def new
    @new_review = NewReview.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @new_review }
    end
  end

  # GET /new_reviews/1/edit
  def edit
    @new_review = NewReview.find(params[:id])
  end

  # POST /new_reviews
  # POST /new_reviews.json
  def create
    @new_review = NewReview.new(params[:new_review])
    @new_review.body = RedCloth.new(@new_review.body).to_html
    if !([:new_review][:photo].nil?)
      image = params[:new_review][:photo]
      image.write "new_review_#{@new_review.id}.jpg"
      @new_review.photo = File.open("new_review_#{@new_review.id}.jpg")
      File.delete("new_review_#{@new_review.id}.jpg")
    end
    
    
    respond_to do |format|
      if @new_review.save
        format.html { redirect_to "/pages/thank_you" }
        format.json { render json: @new_review, status: :created, location: @new_review }
      else
        format.html { render action: "new" }
        format.json { render json: @new_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /new_reviews/1
  # PUT /new_reviews/1.json
  def update
    if user_signed_in? && current_user.admin?
    @new_review = NewReview.find(params[:id])

    respond_to do |format|
      if @new_review.update_attributes(params[:new_review])
        format.html { redirect_to @new_review, notice: 'New review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @new_review.errors, status: :unprocessable_entity }
      end
    end
  else
    redirect_to root_path
  end
  end

  # DELETE /new_reviews/1
  # DELETE /new_reviews/1.json
  def destroy
    if user_signed_in? && current_user.admin?
    @new_review = NewReview.find(params[:id])
    @new_review.destroy

    respond_to do |format|
      format.html { redirect_to new_reviews_url }
      format.json { head :no_content }
    end
  else
    redirect_to root_path
  end
  end

end
