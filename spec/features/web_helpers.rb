# frozen_string_literal: true

def sign_up
  visit '/'
  click_link 'Sign up'

  fill_in('name', with: 'Bob')
  fill_in('email', with: 'test_1@example.com')
  fill_in('password', with: 'password123')
  click_button 'Sign up'
end

