# Rguidepost

Guidepost that indicates useful commands to developers of a repository.

Rguidepost helps executing commands specific to a repository, like package.json's 'scripts' in a node repository.
You can use a YAML file (rguidepost.yml) to define commands instead of package.json in a Ruby repository.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rguidepost'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rguidepost

## Usage

Create rguidepost.yml like below.

```rguidepost.yml
commands:
  "list all files": ls -lah
  "cat rguidepost config file":
    pre_command: list all files
    ignore_pre: true (default: false)
    command: cat rguidepost.yml
    post_command: echo done message
    ensure_post: true (default: false)
  "echo done message": echo 'done!!'
```

Commands can be set under 'commands' key like above.
Keys (command names) under 'commands' should be unique.

rguidepost will abort executing next command if prior command failed (fail means status is not 0), but will execute next command regardless of pre_command status if ignore_pre/ensure_post is true.

Then,

```
$ rguidepost
```

## Development

### Test

Unfortunately, test is nothing yet.

### Docker

```
$ docker-compose build
$ docker-compose run ruby
$ cat .bundle/config
---
BUNDLE_PATH: "vendor/bundle"
$ bundle install
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryokkkke/rguidepost. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/rguidepost/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rguidepost project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/rguidepost/blob/master/CODE_OF_CONDUCT.md).
