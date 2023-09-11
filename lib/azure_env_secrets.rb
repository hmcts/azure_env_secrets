require "azure_env_secrets/version"

module AzureEnvSecrets
  SIGNATURE_RE=/\A\s*<azure\-secret:([^>]*)>\s*\z/
  class Error < StandardError; end
  class SecretFileNotFound < Error; end
  # Your code goes here...
  #
  def self.load
    secrets_path = ENV.fetch('SECRETS_PATH', '').empty?
    return if secrets_path.empty?

    if Dir.exist?(secrets_path)
      Dir["#{secrets_path}/*"].each do |filepath|
        name = filepath.split('/')[-1]
        value = File.open(filepath).read
        ENV[name] = value
      end
    end
  end
end

require 'azure_env_secrets/rails' if Object.const_defined?('Rails')
