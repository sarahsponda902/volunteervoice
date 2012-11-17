class BlogCommentsController < ApplicationController
  #######################################################################
  ### Written (mostly) by Ryan Stout                                #####
  ### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
  #######################################################################


  include ActionView::Helpers::TextHelper
  unloadable
  helper :blog

  layout(BlogKit.instance.settings['layout'] || 'application')

  before_filter :authenticate_admin!, :only => [:destroy]
  before_filter :require_blog_post
  
  respond_to :html, :xml


  def create
    @blog_comment = @blog_post.blog_comments.new(params[:blog_comment])
    @blog_comment.user_id = current_user.id if current_user
    @blog_comment.request = request

    @blog_comment.save
    respond_with(@blog_post)
  end


  def destroy
    @blog_comment = BlogComment.find(params[:id])
    @blog_comment.destroy

    respond_with(@blog_comment)
  end

  private
  def require_blog_post
    @blog_post = BlogPost.find(params[:blog_post_id])
    redirect_to blog_posts_path unless @blog_post
  end


  def authenticate_admin!
    unless current_user && current_user.admin?
      redirect_to blog_posts_path
    end
  end
end