<h1 align="center">
  <br>
  <img width=60% src="https://github.com/metaps/sp-rails-saml/blob/feature/Update_readme/media/logo.png"></p>
</h1>

<p align="center">
  <br>
  <img alt="Gem version" src="https://img.shields.io/gem/v/sp-rails-saml">
  <img alt="Dependencies" src="https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen.svg">
  <img alt="Contributions welcome" src="https://img.shields.io/badge/contributions-welcome-orange.svg">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-blue.svg">
</p>

## :bulb: Introduction

sp-rails-saml is to be make onelogin ruby-saml easier to use in Ruby on Rails.

## :arrow_down: Installation

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

## :wrench: Getting started


### 1. Generate saml templates

You need to run the generator:

```
$ rails g sp_rails_saml:install {reference_table_name}
```

At this point, you need to write your account table name in `reference_table_name`.
This will generate the saml templates for controller, view, model, initializer, etc.


If you need only saml sp initiated and idp initiated template

```
$ rails g sp_rails_saml:install {reference_table_name} --settings false
```

**Controller**
- [app/controllers/saml/sessions_controller.rb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/controllers/sessions_controller.rb)
- [app/controllers/saml/ssos_controller.rb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/controllers/sessions_controller.rb)
- [app/controllers/saml/saml_settings_controller.rb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/controllers/saml_settings_controller.rb)

**View**
- [app/views/saml/sessions/new.html.erb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/views/sessions/new.html.erb)
- [app/views/saml/saml_settings/show.html.erb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/views/saml/show.html.erb)
- [app/views/saml/saml_settings/edit.html.erb](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/views/saml/edit.html.erb)

**Model**
- [app/models/saml_setting.rb](https://github.com/metaps/sp-rails-saml/blob/develop/spec/fixtures/models/saml_setting.rb)

**Migration**
- [db/migrate/create_saml_settings](https://github.com/metaps/sp-rails-saml/blob/develop/lib/generators/sp-rails-saml/templates/migrations/create_saml_settings.rb)

### 2. Add routing

To configure routings for above templates,  just add the following line to your `config/routes.rb`:

```ruby
sp_rails_saml_routes

# if you need only saml sp initiated and idp initiated routing
sp_rails_saml_routes(sso_only: true)
```

This routing method encompasses the following endpoints:

```
# metadata url
GET  /saml/sp/metadata/:id

# acs url
POST /saml/sp/consume/:id

# saml login page
GET  /saml/sign_in

# start saml sp initiated
POST /saml/sign_in

GET   /saml/saml_settings
GET   /saml/saml_settings/edit
PATCH /saml/saml_settings
```

### 3. Setting model associations

If you associate the reference table and the saml model, you need to add the follwing line to your reference model file:

```ruby
has_one :saml_setting, dependent: :destroy
```

### 4. Migrate

You need to run migration command.

```
$ rails db:migrate
```

### 5. Add before action
You need to add the following line to your `SsosController` and `SessionController`:

```ruby
skip_before_action :authenticate_user!
```

### 6. Add SSO method to ApplicationController

You need to add the follwing line to your `ApplicationController`:

```ruby
def sign_in_with_saml(user)
  # add create session logic
end

# using devise example
def sign_in_with_saml(user)
  sign_in(:user, user)
  redirect_to root_path
end
```

### 7. Edit your saml credentials

Once the above process is complete, you can edit your saml credentials in `/saml/saml_settings/edit`.


## Check Saml Value

sp-rails-saml only validate below list value

- SAML Response AudienceRestriction
- SAML Response Signature
- SAML Response Destination

## :page_facing_up: License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

