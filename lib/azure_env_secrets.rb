require "azure_env_secrets/version"

module AzureEnvSecrets
  SIGNATURE_RE=/\A\s*<azure\-secret:([^>]*)>\s*\z/
  class Error < StandardError; end
  # Your code goes here...
  #
  def self.load
    return if ENV.fetch('SECRETS_PATH', '').empty?

    ENV.each do |(key, value)|
      match_data = value.match(SIGNATURE_RE)
      next if match_data.nil?

      path = File.join(ENV['SECRETS_PATH'], match_data[1])
      if File.exist?(path)
        ENV[key] = File.read(path)
      end
    end
  end
end

require 'azure_env_secrets/rails' if Object.const_defined?('Rails')
