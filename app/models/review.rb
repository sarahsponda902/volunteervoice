class Review < ActiveRecord::Base
has_many :review_photos, :dependent => :destroy
accepts_nested_attributes_for :review_photos, :reject_if => lambda { |a| a[:file].blank? }, :allow_destroy => true
  
  
validates :terms, :acceptance => {:accept => true}
validates :organization_id, :presence => true
validates :program_id, :presence => true
validates_length_of :body, :minimum => 200, :message => "Must contain at least 30 
characters."
validates_length_of :body, :maximum => 10000, :message => "You have entered more than 10,000 characters"
belongs_to :program
belongs_to :user



attr_accessible :user_id, :program_id, :body, :rating, :photo, :show, :organization_id, :time_frame, :before, :terms, :preparation, :support, :impact, :structure, :overall, :review_photos_attributes, :organization_name

# Paperclip
mount_uploader :photo, ImageUploader
		
		
    def roundup(overall)
        (overall*2).round / 2.0
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
