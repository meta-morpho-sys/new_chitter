# frozen_string_literal: true

feature 'New peep', :db do
  scenario 'User can create a peep' do
    sign_up

    expect(current_path).to eq '/user/1/peeps'

    click_link 'New peep'
    fill_in('text', with: 'New peep')
    click_button 'Peep'

    expect(page).to have_content 'New peep'
    expect(page).to have_content 'New peep'
  end
end
