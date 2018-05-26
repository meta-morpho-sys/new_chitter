# frozen_string_literal: true

feature 'Viewing peeps', :db do
  scenario 'a user can see all her peeps' do
    sign_up

    expect(current_path).to eq '/user/1/peeps'

    create_peep 'Test peep'
    create_peep 'Test2 peep'
    create_peep 'Test3 peep'

    expect('Test3 peep').to appear_before 'Test2 peep'
    expect('Test2 peep').to appear_before 'Test peep'
  end
end
