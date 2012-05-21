class BlogPostsController < ApplicationController
	unloadable
	
	require 'aws/s3'
  
	helper :blog

	layout :choose_layout

	before_filter :require_user, :except => [:index, :show, :tag]
	before_filter :require_admin, :except => [:index, :show, :tag]

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
  end

  def create
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.new(params[:blog_post])
		@blog_post[:user_id] = current_user.id
		@blog_post.truncated125 = RedCloth.new( sanitize( @blog_post.body[0,124] + "..." ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @blog_post.truncated100 = RedCloth.new( sanitize( @blog_post.body[0,99] + "..." ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
		@blog_post.body = RedCloth.new( sanitize( @blog_post.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html

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
         render :action => "new" 
    end
  else
    redirect_to "/pages/blogs"
  end
  end

  def update
    if (user_signed_in? && current_user.admin?)
    @blog_post = BlogPost.find(params[:id])
    @blog_post.truncated125 = RedCloth.new( sanitize( @blog_post.body[0,124] + "..."), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @blog_post.truncated100 = RedCloth.new( sanitize( @blog_post.body[0,99] + "..." ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @blog_post.body = RedCloth.new( sanitize( @blog_post.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    
      if @blog_post.update_attributes(params[:blog_post])
          flash[:notice] = 'BlogPost was successfully updated.'
          redirect_to "/blog_posts/#{@blog_post.id}"
      else
        render :action => "edit"
      end
    else
      redirect_to "/pages/blogs"
    end
  end


  def destroy
    if (user_signed_in && current_user.admin?)
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