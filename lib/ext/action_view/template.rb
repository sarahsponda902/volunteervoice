module ActionView
class Template
    def render_template(view, local_assigns = {})
      render(view, local_assigns)
    rescue Exception => e
      raise e unless filename

      case e
        when ActiveRecord::RecordNotFound
          raise e
        when TemplateError
          e.sub_template_of(self)
          raise e
        else
          raise TemplateError.new(self, view.assigns, e)
      end

    end
  end
end