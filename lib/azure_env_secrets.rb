require "azure_env_secrets/version"

module AzureEnvSecrets
  SIGNATURE_RE=/\A\s*<azure\-secret:([^>]*)>\s*\z/
  class Error < StandardError; end
  class SecretFileNotFound < Error; end
  # Your code goes here...
  #
  def self.load
    return if ENV.fetch('SECRETS_PATH', '').empty?

    ENV.each do |(key, value)|
      match_data = value.match(SIGNATURE_RE)
      next if match_data.nil?

      path = File.join(ENV['SECRETS_PATH'], match_data[1])
      raise SecretFileNotFound, "The secret '#{match_data[1]}' referenced in env var '#{key}' is not defined as a file in '#{ENV['SECRETS_PATH']}' - maybe it is missing from the keyvault ?" unless File.exist?(path)

      ENV[key] = File.read(path)
    end
  end
end

require 'azure_env_secrets/rails' if Object.const_defined?('Rails')
