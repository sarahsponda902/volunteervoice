class BlogPostsController < ApplicationController
	unloadable
	
	require 'aws/s3'
  include ActionView::Helpers::TextHelper
	helper :blog

	layout :choose_layout

	before_filter :require_user, :except => [:index, :show, :tag, :resources, :resources_search]
	before_filter :require_admin, :except => [:index, :show, :tag, :resources, :resources_search]
	
	
	
  
  def resources_search
    @search_words = params[:search] 
    
    @interesting_search = Sunspot.search(BlogPost) do
      keywords params[:search]
      with :is_our_blog, false
    end
    @our_blog_search = Sunspot.search(BlogPost) do
      keywords params[:search]
      with :is_our_blog, true 
    end
    @interesting_tags_search = Sunspot.search(BlogTag) do
      with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
      with :is_our_blog, false
    end
    @our_blog_tags_search = Sunspot.search(BlogTag) do
      with :tag, params[:search].gsub(/[^0-9A-Za-z]/, "").split(" ")
      with :is_our_blog, true
    end
    @interesting = []
    @our_blog = []
    @interesting_tags_search.results.each do |f|
      @interesting << BlogPost.find(f.blog_post_id)
    end
    @interesting_search.results.each do |f|
      @interesting << f unless @interesting.include?(f)
    end
    @interesting = @interesting.sort_by{|e| e[:published_at]}.reverse
    
    @our_blog_tags_search.results.each do |f|
      @our_blog << BlogPost.find(f.blog_post_id)
    end
    @our_blog_search.results.each do |f|
      @our_blog << f unless @our_blog.include?(f)
    end
    @our_blog = @our_blog.sort_by{|e| e[:published_at]}.reverse
    @results = @interesting + @our_blog
    @results = @results.sort_by{|e| e[:published_at]}.reverse
  end


  def resources
    @interesting = BlogPost.where(:is_our_blog => false).sort_by{|e| e[:published_at]}.reverse
    
    @our_blog = BlogPost.where(:is_our_blog => true).sort_by{|e| e[:published_at]}.reverse

    @boolA = true
    @boolV = true
    
    respond_to do |format|
      format.html
      format.json
    end
  end

  def index
    @blog_posts = BlogPost.published.paginate(:page => params[:page], :order => 'updated_at DESC')
    @index_title = BlogKit.instance.settings['blog_name'] || 'Blog'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_posts }
			format.atom
    end
  end
  
  
  def crop
    if user_signed_in? && current_user.admin?
      @blog_post = BlogPost.find(params[:id])
    else
      redirect_to "/pages/blogs"
    end

  end

	def tag
		@tag = params[:id]
		@blog_tags = BlogTag.find_all_by_tag(params[:id])

		if @blog_tags.size > 0
	    @blog_posts = BlogPost.published.paginate(:page => params[:page], :conditions => ['id IN (?)', @blog_tags.map(&:blog_post_id)], :per_page => 5, :order => 'published_at DESC')
			@blog_posts = []
		end

    @index_title = 'Tag: ' + @tag
    respond_to do |format|
      format.html { render :action => 'index' }
      format.xml  { render :xml => @blog_posts }
    end		
	end

  def drafts
    if (user_signed_in? && current_user.admin?)
    @blog_posts = BlogPost.drafts.paginate(:page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blog_posts }
    end
  else
    redirect_to "/pages/blogs"
  end
  end

  def show
    @blog_post = BlogPost.find(params[:id])
		@blog_comment = @blog_post.blog_comments.new
		@blog_comments = @blog_post.blog_comments.paginate(:page => params[:page], :order => 'created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blog_post }
    end
  end

  def new
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blog_post }
    end
  else
    redirect_to "/pages/blogs"
  end
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
    @blog_post.body = Nokogiri::HTML.fragment(@blog_post.body).text
  end

  def create
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.new(params[:blog_post])
		@blog_post[:user_id] = current_user.id
		@blog_post.truncated125 = RedCloth.new( ActionController::Base.helpers.sanitize( truncate @blog_post.body, :length => 125 ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @blog_post.truncated100 = RedCloth.new( ActionController::Base.helpers.sanitize( truncate @blog_post.body, :length => 100), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
		@blog_post.body = RedCloth.new( ActionController::Base.helpers.sanitize( @blog_post.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html

		if params[:published_at].nil?
      @blog_post.published_at = Time.now
    end

      if @blog_post.save
          if params[:blog_post][:image].blank?
            flash[:notice] = 'BlogPost was successfully created.'
            redirect_to @blog_post
          else
            redirect_to "/blog_posts/#{@blog_post.id}/crop"
          end
      else
        @blog_post.body = @blog_post.body.gsub(%r{</?[^>]+?>}, '')
         render :action => "new" 
    end
  else
    redirect_to "/pages/blogs"
  end
  end

  def update
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.find(params[:id]) 
    if !@blog_post.image.nil? && @blog_post.image != params[:blog_post][:image]
      @crops = true
    end
    params[:blog_post][:body] = RedCloth.new( ActionController::Base.helpers.sanitize( params[:blog_post][:body] ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
      if @blog_post.update_attributes(params[:blog_post])
          flash[:notice] = 'BlogPost was successfully updated.'
          if @crops != true
            redirect_to "/blog_posts/#{@blog_post.id}"
          else
            redirect_to "/blog_posts/#{@blog_post.id}/crop"
          end
      else
        render :action => "edit"
      end
    else
      redirect_to "/pages/blogs"
    end
  end



  def destroy
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.find(params[:id])
    @blog_post.destroy

		flash[:notice] = 'The blog post has been deleted'

    respond_to do |format|
      format.html { redirect_to("/blog_posts") }
      format.xml  { head :ok }
    end
  else
    redirect_to "/pages/blogs"
  end
  end

	private
		def require_admin
			if !current_user || !current_user.admin?
				flash[:notice] = 'You must be an admin to view this page'
				redirect_to blog_posts_path
				return false
			end

			return true
		end
		
		def require_user
		  if !current_user
		    flash[:notice] = 'You must be logged in to view this page'
		    redirect_to blog_posts_path
		    return false
	    end
	    
	    return true
    end

		def choose_layout
			if ['new', 'edit', 'create', 'update'].include?(params[:action])
				BlogKit.instance.settings['admin_layout'] || 'application'
			else
				BlogKit.instance.settings['layout'] || 'application'
			end
		end

	  

	  
end