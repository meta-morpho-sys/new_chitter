# frozen_string_literal: true

def sign_up(name = 'Bob', email = 'test_1@example.com', pswd = 'pswd123')
  visit '/'
  click_link 'Sign up'

  fill_in('name', with: name)
  fill_in('email', with: email)
  fill_in('password', with: pswd)
  click_button 'Sign up'
end

def sign_in(pswd = 'pswd123', user_obj: nil, email_str: nil)
  visit '/'
  click_link 'Sign in'

  expect(current_path).to eq '/login/sign_in'

  fill_in('email', with: email_str || user_obj.email)
  fill_in('password', with: pswd)
  click_button 'Sign in'
end

def create_peep(text)
  click_link 'New peep'
  fill_in('text', with: text)
  click_button 'Peep'
end

def create_with(peep)
  click_link 'New peep'
  fill_in('text', with: peep.text)
  click_button 'Peep'
end

def sign_up_and_peep(name, email, text)
  sign_up name,  email
  create_peep text
end
