# frozen_string_literal: true

feature 'Replies', :db do
  given(:user) { User.create('Bob', 'test_1@example.com', 'pswd123') }
  given(:other_user) { User.create('Anna', 'anna@example.com', 'password123') }
  given(:peep) { Peep.create(user_id: user.id, text: 'Destination SUMMER') }

  scenario 'writing a reply to a peep' do
    sign_in(user_obj: user)

    create_with peep

    click_link 'All peeps'

    within "#peep-#{peep.id}" do
      click_link 'Reply'
    end

    expect(current_path).to eq "/peeps/#{peep.id}/reply"

    fill_in(:text, with: 'Best season!')
    click_button 'Reply'

    expect(page).to have_content 'Best season!'
  end
end
