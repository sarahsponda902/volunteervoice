module ApplicationHelper

def Org_Namer(arg)
	def display_flash(name,msg)
      case name.to_s
      when "notice" then
        content_tag :div, msg, :class => "alert-message success"
      when "alert" then
        content_tag :div, msg, :class => "alert-message warning"
      else
        content_tag :div, msg, :class => "alert-message info"
      end
    end
	
	
	holder = Organization.find(arg)
	holder[:name]
	#take in a Organization ID and return a name
end
end
