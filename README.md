# AzureEnvSecrets

A gem to load environment variables from a secrets folder.

A use case for this is where your deployed applications have a folder mounted containing the secrets rather than specifying them
as environment variables.

At HMCTS, this is how things are done - so this gem should be used in all ruby apps deployed on HMCTS's azure platform

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'azure_env_secrets'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install azure_env_secrets

## Usage

### Rails

If used within a rails project, everything should just work - no more config to do.

To see it in use, set the SECRETS_PATH environment variable to a folder in your file system and put a file in that
folder, naming it EXAMPLE_SECRET and putting some text inside that file.

Then, go into a rails console and type

```

ENV['EXAMPLE_SECRET']

```

and you should see the text that you put inside this file

### Without Rails

If using this gem without rails, you simply need to require it at the earliest point in your bootup sequence.

So

```

require 'azure_env_secrets'

```

and thats it

To see it in use, set the SECRETS_PATH environment variable to a folder in your file system and put a file in that
folder, naming it EXAMPLE_SECRET and putting some text inside that file.

Then, go into a rails console and type

```

ENV['EXAMPLE_SECRET']

```

and you should see the text that you put inside this file

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ministryofjustice/azure_env_secrets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AzureEnvSecrets project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ministryofjustice/azure_env_secrets/blob/master/CODE_OF_CONDUCT.md).
