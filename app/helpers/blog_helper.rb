module BlogHelper
  #######################################################################
  ### Written by Ryan Stout                                         #####
  ### in blog_kit plugin at:  https://github.com/ryanstout/blog_kit #####
  #######################################################################
  
	def blog_tags_list(limit=nil)
		html = []

		limits = {}

		limits[:limit] = limit if limit

		BlogTag.all({:select => 'tag,count(id) as count', :group => 'tag', :order => 'count DESC'}.merge(limits)).sort_by {|bt| bt.tag }.each do |tag|
			html << "<li><a href=\"/blog_posts/tag/#{tag.tag}\">#{tag.tag}</a> (#{tag.count})</li>"
		end

		return "<div class=\"blogTagsList\"><ul>#{html.join}</ul></div>"
	end
end