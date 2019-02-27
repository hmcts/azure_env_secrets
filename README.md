# AzureEnvSecrets

A gem to post process environment variables and any that are defined with the special signature are replaced with the value
from the file system.

A use case for this where your application doesn't want to expose something as a real environment variable where everything
can see it - instead, only the ruby process containing this gem can see it as an environment variable - meaning
all ruby code that uses the environment variable doesnt need to change - which includes gems that use environment variables
such as aws's s3 gem as an example.

At HMCTS, this is how things are done - so this gem should be used in all ruby apps deployed on HMCTS's azure platform

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'azure_env_secrets', git: 'https://github.com/ministryofjustice/azure_env_secrets.git', tag: 'v0.1.3'
```

And then execute:

    $ bundle

## Usage

### Rails

If used within a rails project, everything should just work - no more config to do.

To see it in use, you need to set the SECRETS_PATH environment variable to a folder in your file system, set an
 environment variable to point to the secret - and to put a file in the folder, containing the secret data

So, try this :-

```
export SECRETS_PATH=<the path you chose to store the secrets in>
export MY_EXAMPLE_SECRET="<azure-secret:my-example-secret>"
echo "samplesecret" > $SECRETS_PATH/my-example-secret

```
Then, go into a rails console and type

```

ENV['MY_EXAMPLE_SECRET']

```

and you should see the text "samplesecret"

### Without Rails

If using this gem without rails, you simply need to require it at the earliest point in your bootup sequence.

So

```

require 'azure_env_secrets'

```

and thats it

To see it in use, you need to set the SECRETS_PATH environment variable to a folder in your file system, set an
 environment variable to point to the secret - and to put a file in the folder, containing the secret data

So, try this :-

```
export SECRETS_PATH=<the path you chose to store the secrets in>
export MY_EXAMPLE_SECRET="<azure-secret:my-example-secret>"
echo "samplesecret" > $SECRETS_PATH/my-example-secret

```
Then, go into a rails console and type

```

ENV['MY_EXAMPLE_SECRET']

```

and you should see the text "samplesecret"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ministryofjustice/azure_env_secrets. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AzureEnvSecrets project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ministryofjustice/azure_env_secrets/blob/master/CODE_OF_CONDUCT.md).
