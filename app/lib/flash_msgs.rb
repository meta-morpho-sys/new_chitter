# frozen_string_literal: true

# Responsible for message strings displayed through Flash-Sinatra.
class FlashMsgs
  DUPLICATE_EMAIL = 'This email already exists.'
  LOGIN_REQUIRED = 'You must login first.'
  NO_SUCH_USER = 'No such user.'
  NO_PEEP_FOUND = "Sorry, this peep doesn't exist."
  NO_TEXT_ENTERED = 'You need to enter a text here.'
  WELCOME = ->(name) { "Welcome, #{name}!" }
  WELCOME_BACK = ->(name) { "Welcome back, #{name}!" }
  WRONG_ACCESS_CREDENTIALS = 'Check your email and password'
  SIGN_OUT = 'You successfully signed out!'
end
