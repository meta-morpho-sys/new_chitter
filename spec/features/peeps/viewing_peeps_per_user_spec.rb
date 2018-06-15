# frozen_string_literal: true

feature 'Viewing peeps', :db, :aggregated_failures do
  context 'in correct order and quantity' do
    let(:user) { User.create('Anna', 'anna@anna', 'pswd123') }
    let(:peep1) { Peep.create(user_id: user.id, text: 'Peep1', created_at: Time.now) }
    let(:peep2) { Peep.create(user_id: user.id, text: 'Peep2', created_at: Time.now) }
    background do
      sign_up
      expect(current_path).to eq '/user/1/peeps'
    end
    scenario 'a user can see their peeps sorted with most recent first' do
      create_with peep1
      Timecop.travel(Time.now + 30)
      create_with peep2

      expect(peep2.text).to appear_before peep1.text
    end

    scenario 'a user can see exactly the number of peeps they have created' do
      num_peeps = 100
      num_peeps.times { |i| create_peep "Test#{i} peep" }

      expect(page).to have_css('td.peep',
                               text: /^Test[0-9]+ peep/, count: num_peeps)
    end
  end


  scenario 'the user can see only their peeps within their account' do
    sign_up_and_peep 'Eric', 'eric@example.com', "Eric's peep"
    sign_up_and_peep 'Alice', 'alice@example.com', "Alice's peep"

    expect(page).to have_content "Alice's peep"
    expect(page).not_to have_content "Eric's peep"
  end

  feature "switching between homepage and user's peeps" do
    before do
      sign_up_and_peep 'Eric', 'eric@example.com', "Eric's peep"
      sign_up_and_peep 'Alice', 'alice@example.com', "Alice's peep"
      sign_in email_str: 'eric@example.com'
      click_link 'All peeps'
    end

    scenario "a user can choose to see all peeps once he's signed in" do
      expect(page).to have_content 'Chitter'
      expect(page).to have_content "Eric's peep", "Alice's peep"
    end

    scenario 'and go back to his own peeps' do
      click_link 'Back to my peeps'
      expect(page).to have_content "Eric's page"
    end

  end
end
