# frozen_string_literal: true

feature 'Sign out', :db do
  before { sign_up }
  scenario 'A user can sign out of Chitter' do
    expect(current_path).to eq '/user/1/peeps'

    click_button 'Sign out'

    expect(current_path).to eq '/login/home'
    expect(page).to have_content 'You successfully signed out!'
  end
end
