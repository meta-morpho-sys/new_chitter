# frozen_string_literal: true

feature 'Signing in', :aggregated_failures, :db do
  scenario 'when username and password are correct' do
    user = User.create('Anna', 'anna@anna', 'pswd123')
    sign_in user_obj: user
    expect(page).to have_content 'Welcome back, Anna!'
  end

  context 'the user receives a warning' do
    scenario 'if tries to access without previously signing up' do
      sign_in email_str: 'anna@anna'
      expect(page).to have_content 'No such user.'
    end
  end
end
