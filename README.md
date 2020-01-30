[![ruby](https://img.shields.io/badge/ruby-v2.5.7-red.svg)](https://www.ruby-lang.org/en/)
[![rails](https://img.shields.io/badge/rails-v5.0-orange.svg)](https://rubyonrails.org/)

# READ ME

## Description/Purpose

This is a small rails application that allows users to view a collection of widgets.  An unregistered or logged out user can see a page listing all of the widgets in the collection, inlcuding a link to the user who created it and he/she can search the public/visible widgets.  If an unregistered/logged out user clicks on the widget creator's name, they will be taken to a page that show's that user's detail, along with a listing of all the widgets that user created.

An unregistered user may also register with the web app in order to login to an account.

A logged in user can view their own dashboard.  A user's dashboard will have a listing of their widgets.  A logged in user can create new widgets, delete existing widgets, see more details about a specific widget, edit a widget and search his own widgets.

## System Requirements
- Ruby >= 2.5.7
- Rails >= 5.0

## Initial Setup
1. Clone or fork this project to your local machine.
2. Run `bundle` in the project folder.
3. Add the following API keys to [Rails 5 Credentials](https://medium.com/cedarcode/rails-5-2-credentials-9b3324851336) with the variable names exactly as shown:
    - `client_id`
    - `client_secret`
4. Run `rails db:{create,migrate,seed}` in the project folder.
5. To use the application locally, run `rails s` and navigate to `http:localhost:3000`
6. **Or, use go [here](https://mysterious-brook-62552.herokuapp.com/) to see the application live**

## Running Tests
Run `rspec` to run the full test suite. Following test cases are covered:
1. Feature/Acceptance tests.
2. Model tests.
3. Controller tests.
4. Functional tests.

## Important files to view
1. [ShowoffApiConnectorService](https://github.com/nabeelnazir/Showoff-Application/blob/master/app/services/showoff_api_connector_service.rb) class will connect the showoff API by Net::HTTP and RestClient post put get and delete calls.
2. [ShowoffApiService](https://github.com/nabeelnazir/Showoff-Application/blob/master/app/services/showoff_api_service.rb) class will consume showoff API calls by using ShowoffApiConnectorService class.
3. [WidgetsController](https://github.com/nabeelnazir/Showoff-Application/blob/master/app/controllers/widgets_controller.rb) has all methods for example create, delete, update, edit and search widgets.
4. [Rspec](https://github.com/nabeelnazir/Showoff-Application/tree/master/spec) test cases are present in the app.

## Dependencies
 ### All Environments
 - [Ruby](https://www.ruby-lang.org/en/)
 - [Rails](https://guides.rubyonrails.org/)
 - [Postgresql](https://www.postgresql.org/)
 - [Bootstrap 4](https://getbootstrap.com/docs/4.0/getting-started/introduction/)
 - [Bcrypt](https://github.com/codahale/bcrypt-ruby)

 ### Development
 - [Rspec for Rails](https://github.com/rspec/rspec-rails)
 - [Pry for Rails](https://github.com/rweng/pry-rails)

 
 ### Test
 - [VCR](https://github.com/vcr/vcr)
 - [Webmock](https://github.com/bblimke/webmock)
 - [Capybara](https://github.com/teamcapybara/capybara)
 - [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers)
 - [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner)
 - [Simplecov](https://github.com/colszowka/simplecov)
 
 ### Working demo
 https://drive.google.com/file/d/1GGrLozHEe5-CFJ7EOIUbo4XLFt0spHyS/view?usp=sharing
 
 ## Contributors/Developers
[Iam!](https://github.com/nabeelnazir)
