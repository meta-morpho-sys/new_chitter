Chitter
=================

 A little Twitter clone that will allow the users to post messages to a public stream.

### Prerequisites

The sqlite3 database engine should be installed on your system.

### Getting started:

##### To get started with Bookmark Manager:
 
 ```
 $ git clone https://github.com/meta-morpho-sys/new_chitter
 $ cd new_chitter
 $ bundle install
 $ rake db::create
 $ bundle exec rspec
 ```

This will give you the application, and set up two databases: `new_chitter` for the development environment, 
and `new_chitter_test` for the test environment.

#####   To display all existing tasks for the database 
 `$ rake help ` or `rake`
 
 
##### To launch and interact with the app in the browser:

Type the `rackup` command from the command line in the directory of the app.

##### App security
Specify your session secret key as the environmental variable `SESSION_SECRET`.
If you don't specify this, the app will generate it's own 20 character SecureRandom secret.

### Technologies used
App:
- [BCrypt](https://rubygems.org/gems/bcrypt/versions/3.1.11) - Security algorithm for hashing passwords.
- [Rake](https://github.com/ruby/rake) - Task management and build automation tool.
- [Sequel](https://github.com/jeremyevans/sequel ) -  A simple, flexible, and powerful SQL database access toolkit for Ruby. 
- [Sinatra](https://github.com/sinatra/sinatra) - Quick tool for creating web applications.
- [sqlite3](https://rubygems.org/gems/sqlite3/versions/1.3.11) - A self-contained, embedded, full-featured, SQL database engine. 

Testing:
- [Capybara](https://github.com/teamcapybara/capybara/blob/3.0_stable/README.md) - Simulator of how a user interacts with the app.
- [orderly](https://github.com/jmondo/orderly) - for asserting that some text (this) appears before other text (that) in rspec request specs
- [rspec_sequel_matchers](rspec_sequel_matcher) - A set of matchers for testing of Sequel gem validations. 
- [RSpec](https://github.com/rspec/rspec) - Behaviour Driven Development for Ruby.
- [timecop](https://github.com/travisjeffery/timecop) - A gem for testing time-dependent code
