Chitter
=================

 A little Twitter clone that will allow the users to post messages to a public stream.

### Prerequisites

The PostgreSQL database management system should be installed on your system.

### Getting started:

##### To get started with Bookmark Manager:
 
 ```
 $ git clone https://github.com/meta-morpho-sys/new_chitter
 $ cd new_chitter
 $ bundle install
 $ rake create_databases
 $ rspec
 ```

This will give you the application, and set up two databases: `new_chitter` for the development environment, 
and `new_chitter_test` for the test environment.

#####   To display all existing tasks for the database 
 `$ rake help ` or `rake`
 
 
##### To launch the app in the browser:

From the command line `cd` into the app's directory and type the `rackup` command.

##### App security
Specify your session secret key as the environmental variable `SESSION_SECRET`.
If you don't specify this, the app will generate it's own 20 character SecureRandom secret.

### Technologies used
App:
- [Sinatra](https://github.com/sinatra/sinatra) - Quick tool for creating web applications.
- [Sequel] - 
- [PG](https://deveiate.org/code/pg/) - The Ruby PostgreSQL Driver.
- [BCrypt](https://rubygems.org/gems/bcrypt/versions/3.1.11) - Security algorithm for hashing passwords.
- [Rake](https://github.com/ruby/rake) - task management and build automation tool.

Testing:
- [RSpec](https://github.com/rspec/rspec) - Behaviour Driven Development for Ruby.
- [Capybara](https://github.com/teamcapybara/capybara/blob/3.0_stable/README.md) - Simulator of how a user interacts with the app.
- [timecop](https://github.com/travisjeffery/timecop) - A gem for testing time-dependent code
