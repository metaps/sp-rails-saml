module SpRailsSaml
  class Settings
    class << self
      attr_accessor :sp_entity_id
      attr_accessor :name_identifier_format
      attr_accessor :authn_context
      attr_accessor :authn_context_comparison
      attr_accessor :idp_sso_service_url
      attr_accessor :assertion_consumer_service_url
      attr_accessor :idp_cert
      attr_accessor :idp_entity_id

      def setup(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end
    end
  end
end