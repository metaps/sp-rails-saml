module SpRailsSaml
  # SAML2 settings for initializer.
  #
  class Settings
    RUBY_SAML_DEFAULT_SETTINGS = {
      compress_request: false,
      skip_subject_confirmation: true,
      skip_conditions: true
    }.freeze

    class << self
      attr_accessor :sp_entity_id,
                    :name_identifier_format,
                    :authn_context,
                    :authn_context_comparison,
                    :assertion_consumer_service_url,
                    :user_class,
                    :account_class

      def setup(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end
    end
  end
end
