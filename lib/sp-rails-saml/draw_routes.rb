require 'action_dispatch'

module DrawRoute
  RoutesNotFound = Class.new(StandardError)

  def sp_rails_saml_routes(sso_only: false)
    @sso_only = sso_only
    path = File.expand_path('routes/routes_template.rb', __dir__)
    instance_eval(File.read(path))
    true
  end
end

ActionDispatch::Routing::Mapper.prepend DrawRoute
