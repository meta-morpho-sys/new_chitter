# frozen_string_literal: true

feature 'User can create a peep', :db do
  scenario 'User c  an create a peep' do
    # setup
    user = User.create('Bob', 'bob@bob', 'pswd')
    sign_up

    peep_text = "Bob's peep"
    create_peep peep_text
    peep = Peep.create(user_id: user.id, text: peep_text, created_at: Time.now)

    expect(page.html).to include peep.html
  end
end
