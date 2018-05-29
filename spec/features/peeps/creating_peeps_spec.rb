# frozen_string_literal: true

feature 'New peep', :db do
  scenario 'User can create a peep' do
    frozen_time = Time.now
    sign_up
    expect(current_path).to eq '/user/1/peeps'

    create_peep 'New peep'
    expect(page).to have_content 'New peep'
    expect(page).to have_content "created on #{frozen_time.asctime}"
  end
end
