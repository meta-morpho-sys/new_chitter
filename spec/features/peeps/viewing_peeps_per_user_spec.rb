# frozen_string_literal: true

feature 'Viewing peeps', :db do
  scenario 'a user can see their peeps sorted with most recent first' do
    sign_up

    expect(current_path).to eq '/user/1/peeps'

    create_peep 'Test peep'
    create_peep 'Test2 peep'
    create_peep 'Test3 peep'

    expect('Test3 peep').to appear_before 'Test2 peep'
    expect('Test2 peep').to appear_before 'Test peep'
  end

  scenario 'a user can see exactly the number of peeps they have created' do
    sign_up
    expect(current_path).to eq '/user/1/peeps'

    num_peeps = 100
    num_peeps.times { |i| create_peep "Test#{i} peep" }

    expect(page).to have_css('td.peep',
                             text: /^Test[0-9]+ peep/, count: num_peeps)
  end

  scenario 'the user can see only their peeps within their account' do
    sign_up_and_peep 'Eric', 'eric@example.com', "Eric's peep"
    sign_up_and_peep 'Alice', 'alice@example.com', "Alice's peep"

    expect(page).to have_content "Alice's peep"
    expect(page).not_to have_content "Eric's peep"
  end
end