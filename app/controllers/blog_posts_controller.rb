class BlogPostsController < ApplicationController
  #######################################################################
  ### Written (mostly) by Ryan Stout                                #####
  ### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
  #######################################################################  

  unloadable

  # for image uploads to amazon s3
  require 'aws/s3'

  # for converting textile back to regular text in 'create'
  include ActionView::Helpers::TextHelper

  helper :blog

  before_filter :require_user, :except => [:index, :show, :tag, :resources, :resources_search]
  before_filter :require_admin, :except => [:index, :show, :tag, :resources, :resources_search]

  respond_to :html, :xml, :atom

  # called by the search bar at the top of '/resources'
  # uses sunspot's search
  def resources_search
    @search_words = params[:search] 

    ## Search blog posts with keywords
    @post_search = Sunspot.search(BlogPost) do
      keywords params[:search]
    end

    ## Search blog post tags with keywords
    @tag_search = Sunspot.search(BlogTag) do
      with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
    end

    ## Combine posts & tags searches, without duplicates (UNION)
    @search_results = @post_search.results | @tag_search.results.map{|tag| tag.blog_post}
    @search_results = @results.sort_by{|e| e[:published_at]}.reverse
  end


  ## Resources (all blog posts) landing page
  def resources
    ## Two types of blog posts, interesting (articles) and our_blog (staff written)
    @interesting = BlogPost.where(:is_our_blog => false).sort_by{|e| e[:published_at]}.reverse 
    @our_blog = BlogPost.where(:is_our_blog => true).sort_by{|e| e[:published_at]}.reverse
  end


  ## Index page only for OUR_BLOG posts, written by staff
  def index
    @blog_posts = BlogPost.published.paginate(:page => params[:page], :order => 'updated_at DESC')
    @index_title = BlogKit.instance.settings['blog_name'] || 'Blog'

    respond_with(@blog_posts)
  end


  ## Admin only crop page for cropping the blog images
  def crop
    @blog_post = BlogPost.find(params[:id])
  end


  def tag
    @tag = params[:id]
    @blog_tags = BlogTag.find_all_by_tag(params[:id])

    if @blog_tags.size > 0
      @blog_posts = BlogPost.published.paginate(:page => params[:page], :conditions => ['id IN (?)', @blog_tags.map(&:blog_post_id)], :per_page => 5, :order => 'published_at DESC')
    end

    @index_title = 'Tag: ' + @tag
    respond_with(@blog_post)	
  end


  ## Show a single post
  def show
    @blog_post = BlogPost.find(params[:id])
    @blog_comment = @blog_post.blog_comments.new
    @blog_comments = @blog_post.blog_comments.paginate(:page => params[:page], :order => 'created_at DESC')

    respond_with(@blog_post)
  end


  ## Admin only 'new' blog post page
  def new
    @blog_post = BlogPost.new

    respond_with(@blog_post)
  end


  ##Admin only edit blog post page
  def edit
    @blog_post = BlogPost.find(params[:id])

    # Convert RedCloth textile (now in html) back to normal text format
    @blog_post.body = Nokogiri::HTML.fragment(@blog_post.body).text
  end


  ##Admin only create new blog post (interesting or our_blog)
  def create
    @blog_post = BlogPost.new(params[:blog_post])
    @blog_post[:user_id] = current_user.id

    ## Textilize the body (to leave in newlines, etc.)
    @blog_post.body = RedCloth.new( ActionController::Base.helpers.sanitize( @blog_post.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html

    ## Set the published_at date/time
    @blog_post.published_at = Time.now

    if @blog_post.save
      ## if there is no image attached to the post
      if params[:blog_post][:image].blank?
        flash[:notice] = 'BlogPost was successfully created.' ## don't send to crop page
        redirect_to @blog_post
        ## otherwise send to crop image to make it 3:1 ratio (length:height)
      else
        redirect_to "/blog_posts/#{@blog_post.id}/crop"
      end
    else
      ## if save was unsuccessful, take out textilization so that <p>s, etc. are not in text box
      @blog_post.body = Nokogiri::HTML.fragment(@blog_post.body).text
      render :action => "new" 
    end
  end


  ## Admin only update a blog post
  def update
    @blog_post = BlogPost.find(params[:id])

    ## If blog post has image attached and it is NEW, set 'crops' to true
    ### 'crops' will send admin to the 'crop' page so they can crop the new image
    if !@blog_post.image.nil? && @blog_post.image != params[:blog_post][:image]
      @crops = true
    end

    ## Textilize body before parameter update
    params[:blog_post][:body] = RedCloth.new( ActionController::Base.helpers.sanitize( params[:blog_post][:body] ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html

    if @blog_post.update_attributes(params[:blog_post])
      # if image is old (or non-existant), send to completed blog post page
      if @crops != true
        redirect_to @blog_post
      else # if image is new and should be cropped
        redirect_to "/blog_posts/#{@blog_post.id}/crop"
      end
    else
      ## if save was unsuccessful, take out textilization so that <p>s, etc. are not in text box
      @blog_post.body = Nokogiri::HTML.fragment(@blog_post.body).text
      render :action => "edit"
    end
  end


  ## Admin only destroy blog post
  def destroy
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_path }
      format.xml  { head :ok }
    end
  end



  private

  ## for before_filter call
  def require_admin
    unless current_user && current_user.admin?
      flash[:notice] = 'You must be an admin to view this page'
      redirect_to blog_posts_path
    end
  end


  ## for before_filter call
  def require_user
    unless current_user
      flash[:notice] = 'You must be logged in to view this page'
      redirect_to blog_posts_path
    end
  end




end