# frozen_string_literal: true

feature 'Signing in', :db do
  scenario 'when username and password are correct' do
    sign_up
    sign_in
    expect(page).to have_content 'Welcome back, Bob!'
  end

  context 'the user receives a warning' do
    scenario 'if tries to access without previously signing up' do
      sign_in
      expect(page).to have_content 'No such user.'
    end
  end
end
