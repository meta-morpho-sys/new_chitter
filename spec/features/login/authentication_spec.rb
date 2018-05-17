# frozen_string_literal: true

feature 'A user can log in providing his credentials', :db do
  before { sign_up }
  scenario 'when username and password are correct' do
    visit '/'
    click_link 'Sign in'

    expect(current_path).to eq '/login'

    fill_in('email', with: 'test_1@example.com')
    fill_in('password', with: 'password123')
    click_button 'Sign in'

    expect(page).to have_content 'Welcome, Bob!'
    # TODO: Welcome AGAIN Bob
  end
end
