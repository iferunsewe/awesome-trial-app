# README

This is an app used to document awesome list technologies, categories and their respective repositories

## Installation

To install this repository please do the following:

  1. `git clone git@github.com:iferunsewe/awesome-trial-app.git`
  2. `cd awesome-trial-app`
  3. `bundle install` (this will install all the dependencies)
  4. `bundle exec rake db:create db:migrate` (this will create the database and run migrations)

## Usage


In order to use the app, please do the following from your local awesome-trial-app respository:

  1. bundle exec rails s -p 3000(this will start a local server for you)
  2. Open up the browser and go to `http://localhost:3000`

### Pages

1. / - Shows all the technologies
2. `/:technology_name` - Shows all the categories for the technology `<technology_name>`
3. `/:technology_name/:category_name` - Shows all the repositories for the category `<category_name>`
4. `/repositories/new` - A form to create repositories, categories and technologies. If the name of any of these respective objects exist in the database then they won't be created again.

## Testing

To run the tests for this project, please run the following from your local store_api respository:

  `bundle exec rspec`
