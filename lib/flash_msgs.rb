# frozen_string_literal: true

# Responsible for message strings displayed through Flash-Sinatra.
class FlashMsgs
  DUPLICATE_EMAIL = 'This email already exists.'
  WELCOME = ->(name) { "Welcome, #{name}!" }
  WELCOME_BACK = ->(name) { "Welcome back, #{name}!" }
  WRONG_ACCESS_CREDENTIALS = 'Check your email and password'
  SIGN_OUT = 'You successfully signed out!'
end
