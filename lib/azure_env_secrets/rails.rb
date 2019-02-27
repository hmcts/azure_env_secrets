module AzureEnvSecrets
  class Rails < ::Rails::Railtie
    config.before_configuration { ::AzureEnvSecrets.load }
  end
end
