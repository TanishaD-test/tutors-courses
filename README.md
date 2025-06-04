# README

This README document whatever steps are necessary to get the
application up and running.

Things you may want to execute:

* Setup Ruby and rails version

* We are using Mysql version ~> 0.5.6

* bundle install

* Setup database.yml with username and password

* rails db:create

* rails db:migrate

* run application on the local server ~> rails s

* Run curl from your system terminal
    curl -X POST http://localhost:3000/api/v1/courses \
    -H "Content-Type: application/json" \
    -d '{
    "course": {
        "name": "Mathematics",
        "tutors_attributes": [
        { "name": "Alice" },
        { "name": "Bob" }
        ]
    }
    }'

* rails db:migrate RAILS_ENV=test and run specs ~> bundle exec rspec

