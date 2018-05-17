# frozen_string_literal: true

feature 'Registration', :db do

  scenario 'a user can sign up' do
    sign_up
    expect(page).to have_content 'Welcome, Bob!'
  end
end
