module DeviseHelper
  #######################################################################
  ### Originally written by Platformatec                         ########
  ### in Devise gem at:  https://github.com/plataformatec/devise ########
  ### EDITED (style) by VolunteerVoice staff                     ########
  #######################################################################
  
  
  # A simple way to show error messages for the current devise resource. If you need
  # to customize this method, you can either overwrite it in your application helpers or
  # copy the views to your application.
  #
  # This method is intended to stay simple and it is unlikely that we are going to change
  # it to add more behavior or options.
  
  
  def devise_error_messages! 
     html = ""

     return html if resource.errors.empty?

     errors_number = 0 

     # VolunteerVoice error messages styling
     html << "<ul class=\"#{resource_name}_errors_list\", style='text-align:center; 
     width:100%; 
     padding: 10px 0 10px 0;
     line-height:1.5em;
     margin-top: 1em;
     color: #e67b5a;
     border: 1px solid #e67b5a; 
     font-family:architectsDaughterRegular;
     background: #c1dfdb;
     font-size:1.1em'>"

     saved_key = ""
     resource.errors.each do |key, value|
       if key != saved_key
           html << "<li class=\"#{key} error\"> #{key} #{value} </li>"
         errors_number += 1
       end
       saved_key = key
     end

     html << "</ul>"

     return html.html_safe
  end
end