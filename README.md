# Etna


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'etna'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install etna

## Usage

This is a general purpose Json API client library on top of Typhoeus. You can implement the 4 general verbs like:


### GET

```ruby
client = Etna::Client.new('http://some_service')
client.get("/users")

```

### POST

```ruby
client = Etna::Client.new('http://some_service')
client.post("/users",  { name: 'Calisto', last_name: 'Mejidez' })

```

### PATCH

```ruby
client = Etna::Client.new('http://some_service')
client.patch("/users/34",  { name: 'Calisto', last_name: 'Mejidez' })

```

### DELETE

```ruby
client = Etna::Client.new('http://some_service')
client.delete("/users/34")

```

## Responses

Responses can be of the kind:

### Entity

`Etna::Components::Responses::Entity`

### Collection

`Etna::Components::Responses::Collection`

### Error

`Etna::Components::Responses::ApiError`

The Responses objects accepts response's attributes and delegates them to the internal Typhoeus object. Also they implement an unified interface with the following methods.

```ruby
  reponse.uid
  reponse.success?
  reponse.error?
  reponse.code
  reponse.to_h
  reponse.body
```

And collections implement extra methods:

```ruby
  reponse.to_a
  reponse[] # Iterator
```

## Testing

If you would like to test how this library respond to API's you could use any api from list of [Public APIs](https://github.com/public-apis/public-apis) 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/etna. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Etna project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/etna/blob/master/CODE_OF_CONDUCT.md).
