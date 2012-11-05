class ReviewsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  before_filter :authenticate_user!, :only => [:create, :new, :edit, :destroy]
  before_filter :check_for_admin, :only => [:index, :changeShow, :changeFlagShow]

  # page showing all reviews (sorted) published on vvi
  # can access this page by clicking "# voices heard" on homepage
  def show_all
    @sort_by = params[:sort_by]
    if @sort_by.nil? || @sort_by == "rating_high"
      @reviews = Review.all.sort_by(&:overall).reverse
    elsif @sort_by == "rating_low"
      @reviews = Review.all.sort_by(&:overall)
    elsif @sort_by == "organization_name_az"
      @reviews = Review.all.sort{|a,b| Organization.find(a.organization_id).name.downcase <=> Organization.find(b.organization_id).name.downcase}
    elsif @sort_by == "organization_name_za"
      @reviews = Review.all.sort{|a,b| Organization.find(a.organization_id).name.downcase <=> Organization.find(b.organization_id).name.downcase}.reverse
    else
      @reviews = Review.all.sort_by(&:created_at)
    end
    @flag = Flag.new
  end

  # User only create a new review
  def create
      @review = Review.new(params[:review])
      @review.body = textilized( @review.body )
      
      # since the review's organization parameter only gives a name,
      #  have to do a search for organization with that name
      #  Note: each organization has a unique name, so this works fine.
      @review.organization_id = Organization.where(:name => @review.organization_name).first.id
      
      # @user_review_progs used for checking if a user has reviewed a program before
      @user_review_progs = current_user.reviews.map{|rev| rev.program_id}
 
      if !(@user_review_progs.include?(@review.program_id))
        respond_to do |format|
          if @review.save
            format.html { redirect_to "/reviews/thank_you_review" }
            format.json { render json: @review, status: :created, location: @review }
          else
            # un-textilize body so it looks normal in text area box if errors
            @review.body = untextilized(@review.body)
            flash[:notice] = flash[:notice].to_a.concat @review.errors.full_messages
            format.html { render action: "new" }
            format.json { render json: @review.errors, status: :unprocessable_entity }
          end
        end
      else # if user has already reviewed this program
        # redirect to "edit review" page, where user can add on to their review, but can't change the old body
        @review_id = Review.where(:program_id => @review.program_id, :user_id => current_user.id).first.id
        flash[:notice] = flash[:notice].to_a.concat(@review.errors.full_messages).concat(["You can only review a program once. Please add on to your review instead!"])
        redirect_to(edit_review_path(:id => @review_id, :edit_review_body => untextilized(@review.body)))
      end
  end

  # thank you page after a user reviews a program
  def thank_you_review
  end


  # Admin only index page
  def index
      @reviews = Review.all.reverse

      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @reviews }
      end
  end

  # GET /reviews/1
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @review }
    end
  end


  # User only write-a-review page
  def new
    @review = Review.new
    
    # get the program & org id params (though they may be null)
      @review.organization_id = params[:organization_id]
      @review.program_id = params[:program_id]
      
      respond_to do |format|
        format.html # new.html.erb
        format.json { render :json => @review }
      end
  end


  # edit review page (user only)
  def edit
    @review = Review.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @review }
    end
  end

  
  def update
    @review = Review.find(params[:id])
    
    # add review add-on to review body with "Update XX/XX/XXXX: \n"
    params[:review][:body] = "Update #{Time.now.to_date.strftime("%m/%e/%Y").gsub(/^0/, '')}: \n"+textilized(params[:review][:body]) + "<br />"+@review.body

    # check if review belongs to user OR user is an admin
    if (current_user.admin? || current_user.id == @review.user_id)

      respond_to do |format|
        if @review.update_attributes(params[:review])
          format.html { redirect_to "/users/profile", :notice => 'Review Submitted' }
          format.json { head :no_content }
        else
          params[:review][:body] = @review.body
          flash[:notice] = flash[:notice].to_a.concat @review.errors.full_messages
          format.html { render :action => "edit" }
          format.json { render :json => @review.errors, :status => :unprocessable_entity }
        end
      end
    else # if review does not belong to user AND user is not an admin
      redirect_to root_path
    end
  end


  # Admin & User only destroy method
  def destroy
    @review = Review.find(params[:id])
    
    # check if review belongs to user OR user is an admin
    if (current_user.admin? || current_user.id == @review.user_id)
      @review_id = @review.program_id
      @review.destroy

      respond_to do |format|
        if current_user.admin?
          format.html { redirect_to reviews_path }
        else
          format.html { redirect_to "/users/profile" }
        end
        format.json { head :no_content }
      end
    else # if review does not belong to user AND user is not an admin
      redirect_to root_path
    end 

  end


  # Admin only 
  # change whether the review can be displayed on the home page or not
  def changeShow
      @review = Review.find(params[:id])
      if @review.show
        @review.show = false
      else
        @review.show = true
      end
        @review.save
      respond_to do |format|
        format.html {redirect_to reviews_path}
      end
  end

  # called by Admin or if a review is flagged for the first time
  # change whether the review can be displayed at all 
  def changeFlagShow
      @review = Review.find(params[:id])
      if @review.flag_show
        @review.flag_show = false
      else
        @review.flag_show = true
      end
      @review.save
      respond_to do |format|
        format.html {redirect_to flags_path}
      end
  end
  
  private
  ## check_for_admin called by before_filter
  def check_for_admin
    unless user_signed_in? && current_user.admin?
      redirect_to root_path
    end
  end

end
