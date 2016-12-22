[The app is available in production on Heroku!](https://pushpinned.herokuapp.com/)

# PushPin

This web platform allows users to search for, post, and take on projects posted
by other users.

# How to install

### First:
Pick your favorite directory, then:

`git clone git@github.com:rtravitz/pushpin.git`

`cd pushpin`

### Second:
Run `bundle`. You'll need to be using Ruby 2.3.0. If you don't have that,
and you have rvm installed, you can run:

`rvm install ruby-2.3.0` ... to get 2.3.0.

The Gemfile should automatically switch rubies for you when you open PushPin

but if not, you can do `rvm use 2.3.0`.

### Third:
Now, you'll need to make sure your PostgreSQL database is running. If you've got

a small elephant at the top of your screen: great. If not, spin up your PostgreSQL app.

(If you don't have the app, go [here](http://postgresapp.com/) and follow the install instructions.)

### Fourth:
Next: run the following command in your terminal:

`rake db:create db:migrate db:seed db:test:prepare`

### Fifth:

Run `rspec` - make sure all the tests pass.  

If not, you might be missing a gem or maybe you should go back and run

`rake db:test:prepare`.

## API Documentation  
API supports get and post requests for messages  
Find full documentation [here]() 

## Technical details:

A Rails app using a PostgreSQL database. Tests written in rspec-rails,
with dummy items coming from Factory Girl. Coverage provided by
SimpleCov.
