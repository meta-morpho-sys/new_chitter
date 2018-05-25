# frozen_string_literal: true

def sign_up
  visit '/'
  click_link 'Sign up'

  fill_in('name', with: 'Bob')
  fill_in('email', with: 'test_1@example.com')
  fill_in('password', with: 'password123')
  click_button 'Sign up'
end

def sign_in
  visit '/'
  click_link 'Sign in'

  expect(current_path).to eq '/login/sign_in'

  fill_in('email', with: 'test_1@example.com')
  fill_in('password', with: 'password123')
  click_button 'Sign in'
end

def create_peep(text)
  click_link 'New peep'
  fill_in('text', with: text)
  click_button 'Peep'
end
