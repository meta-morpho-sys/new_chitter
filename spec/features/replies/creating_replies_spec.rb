# frozen_string_literal: true

feature 'Replies', :db do
  given(:user) { User.create('Bob', 'test_1@example.com', 'pswd123') }
  given(:other_user) { User.create('Anna', 'anna@example.com', 'pswd123') }
  given(:peep) { Peep.create(user_id: user.id, text: 'Destination SUMMER', created_at: Time.now) }

  background do
    sign_in(user_obj: user)
    create_with peep
    click_button 'Sign out'

    sign_in(user_obj: other_user)
    click_link 'All peeps'

    within "#peep-#{peep.id}" do
      click_link 'Reply'
    end
    expect(current_path).to eq "/peeps/#{peep.id}/reply"
  end

  scenario 'writing a regular reply to a peep' do
    fill_in(:text, with: 'Best season!')
    click_button 'Reply'

    expect(page).to have_content 'Best season!'
  end

  feature 'testing null entries' do
    scenario 'user receives a warning if no text is entered' do
      fill_in(:text, with: nil)
      click_button 'Reply'

      expect(page).to have_content 'You need to enter a text here.'
    end
  end
end
