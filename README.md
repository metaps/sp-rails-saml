# sp-rails-saml

sp-rails-saml is to be make onelogin ruby-saml easier to use in Ruby on Rails.

## Installation

sp-rails-saml works with Rails 6.1 onwards.
Add the following line to your Gemfile:

```ruby
gem 'sp-rails-saml'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install sp-rails-saml
```

## Usage

### 1. Generate saml templates

You need to run the generator:

```
$ rails g sp_rails_saml:install {reference_table_name}
```

At this point, you need to write your account table name in `reference_table_name`.
This will generate the saml templates for controller, view, initializer, etc.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

