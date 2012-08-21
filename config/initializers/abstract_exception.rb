require 'action_dispatch/middleware/show_exceptions'

module ActionDispatch
  class ShowExceptions
    private
    def render_exception_with_template(env, exception)
      if exception.kind_of? AbstractController::ActionNotFound
        request = Request.new(env)
        if request.env['action_dispatch.request.path_parameters'][:controller] =~ /^api\/.+/
          return Api::BaseController.action(:render_not_found).call(env)
        end
      end
      render_exception_without_template(env, exception)
    end
    alias_method_chain :render_exception, :template
  end
end
