# frozen_string_literal: true

feature 'Viewing peeps', :db, :aggregated_failures do
  scenario 'all peeps che be viewed by any user' do
    sign_up_and_peep 'Alice', 'alice@example.com', "Alice's peep"
    click_button 'Sign out'

    sign_up_and_peep 'Eric', 'eric@example.com', "Eric's peep"
    click_button 'Sign out'

    visit '/'
    expect(page).to have_content "Alice's peep", 'Alice'
    expect(page).to have_content "Eric's peep", 'Eric'
  end

  scenario 'peeps are displayed in a most recent first order' do
    sign_up_and_peep 'Alice', 'alice@example.com', "Alice's peep"
    click_button 'Sign out'
    Timecop.travel(Time.now + 10)

    sign_up_and_peep 'Eric', 'eric@example.com', "Eric's peep"
    click_button 'Sign out'
    Timecop.travel(Time.now + 10)

    sign_up_and_peep 'Pippo', 'pippo@example.com', "Pippo's peep"
    click_button 'Sign out'

    visit '/'

    expect("Eric's peep").to appear_before "Alice's peep"
    expect("Pippo's peep").to appear_before "Eric's peep"
  end
end
