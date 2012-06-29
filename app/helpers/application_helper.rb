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

def time_in_words(distance_in_seconds)
  %w(year month week day).each do |interval|
      # For each interval type, if the amount of time remaining is greater than
      # one unit, calculate how many units fit into the remaining time.
      if distance_in_seconds >= 1.send(interval)
        delta = (distance_in_seconds / 1.send(interval)).floor
        distance_in_seconds -= delta.send(interval)
        components << pluralize(delta, interval)
      end
    end

    components.join(" and ")
end



end
