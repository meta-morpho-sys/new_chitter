# frozen_string_literal: true

feature 'Registration', :db do

  scenario 'a user can sign up' do
    visit '/'
    click_link 'Sign up'

    fill_in('name', with: 'Bob')
    fill_in('email', with: 'test_1@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign up'

    expect(page).to have_content 'Welcome, Bob!'
  end
end
