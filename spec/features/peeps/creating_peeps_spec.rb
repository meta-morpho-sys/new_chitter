# frozen_string_literal: true

# TODO: Need to find a way to integrate the abstraction into the Capybara test.
# TODO: The abstraction currently is expressed in erb peep.erb see line 50
feature 'User can create a peep', :db do
  scenario 'User c  an create a peep' do
    # setup
    user = User.create('Bob', 'bob@bob', 'pswd')
    sign_up

    peep_text = "Bob's peep"
    create_peep peep_text
    peep = Peep.create(user_id: user.id, text: peep_text, created_at: Time.now)

    expect(page.html).to include peep.erb
  end
end
