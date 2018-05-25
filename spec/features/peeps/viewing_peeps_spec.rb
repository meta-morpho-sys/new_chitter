# frozen_string_literal: true

feature 'Viewing peeps', :db do
  scenario 'a user can see all her peeps' do
    sign_up

    expect(current_path).to eq '/user/1/peeps'

    click_link 'New peep'
    fill_in('text', with: 'Test peep')
    click_button 'Peep'

    click_link 'New peep'
    fill_in('text', with: 'Test2 peep')
    click_button 'Peep'

    click_link 'New peep'
    fill_in('text', with: 'Test3 peep')
    click_button 'Peep'

    expect(page).to have_content 'Test peep'
    expect(page).to have_content 'Test2 peep'
    expect(page).to have_content 'Test3 peep'
  end
end
