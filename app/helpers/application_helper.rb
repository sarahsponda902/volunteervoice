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

def link_to_remove_fields(name, f)
  f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
end

def link_to_add_fields(name, f, association)
  new_object = f.object.class.reflect_on_association(association).klass.new
  fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
    render(association.to_s.singularize + "_fields", :f => builder)
  end
  link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
end



end
