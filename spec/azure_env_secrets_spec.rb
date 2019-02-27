# frozen_string_literal: true
RSpec.describe AzureEnvSecrets do
  subject(:service) { described_class }
  it "has a version number" do
    expect(AzureEnvSecrets::VERSION).not_to be nil
  end


  describe '#load' do
    let(:example_env_data) do
      {
        'AWS_ACCESS_KEY' => 'arealaccesskey',
        'SUPER_SENSITIVE_PASSWORD' => '<azure-secret:super-sensitive-password>',
        'ANOTHER_SENSITIVE_PASSWORD' => '<azure-secret:another-sensitive-password>',
        'PLAIN_BORING' => 'plain boring value'
      }.freeze
    end

    context 'when disabled (no SECRETS_PATH)' do
      it 'does not change the input data' do
        # Arrange - add the example env data to ENV
        ENV.update(example_env_data)

        # Act - Load
        service.load

        # Assert - Make sure nothing has changed
        expect(ENV.to_hash).to include example_env_data
      end
    end

    context 'when enabled (SECRETS_PATH pointing to a temp directory)' do
      around do |example|
        Dir.mktmpdir do |dir|
          # Arrange - add the example env data to ENV
          ENV.update(example_env_data)
          ENV['SECRETS_PATH'] = dir
          File.open(File.join(dir, 'super-sensitive-password'), 'w') { |f| f.write 'This is the super sensitive password' }
          File.open(File.join(dir, 'another-sensitive-password'), 'w') { |f| f.write 'This is another sensitive password' }
          example.run
        end
      end

      it 'changes SUPER_SENSITIVE_PASSWORD' do
        # Act - Load
        service.load

        # Assert - Make sure SUPER_SENSITIVE_PASSWORD has changed
        expect(ENV.to_hash).to include 'SUPER_SENSITIVE_PASSWORD' => 'This is the super sensitive password'
      end

      it 'changes ANOTHER_SENSITIVE_PASSWORD' do
        # Act - Load
        service.load

        # Assert - Make sure SUPER_SENSITIVE_PASSWORD has changed
        expect(ENV.to_hash).to include 'SUPER_SENSITIVE_PASSWORD' => 'This is the super sensitive password'
      end

      it 'does not modify the plain env vars' do
        # Act - Load
        service.load

        # Assert - Make sure SUPER_SENSITIVE_PASSWORD has changed
        expect(ENV.to_hash).to include example_env_data.slice('AWS_ACCESS_KEY', 'PLAIN_BORING')
      end
    end
  end
end
