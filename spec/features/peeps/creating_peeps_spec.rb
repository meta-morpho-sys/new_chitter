# frozen_string_literal: true

# describe 'User can create a peep', type: :view do
#   it 'finds a peep' do
#     # Time.now.freeze
#     #
#     # # setup
#     # sign_up
#     # expect(current_path).to eq '/user/1/peeps'
#
#     assign :peep, Peep.new(id: 5, user_id: 3, text: "Bob's peep", created_at: Time.now)
#
#     render
#     expect(rendered).to have_css('tr', text: "Bob's peep")
#   end
# end

# feature 'New peep', :db do
#   scenario 'User *** create a peep' do
#     frozen_time = Time.now
#
#     expected_string = frozen_time.strftime(StrMsgs::TIME_FORMAT).strip
#     sign_up
#     expect(current_path).to eq '/user/1/peeps'
#
#     create_peep "Bob's peep"
#     expect(page).to have_content expected_string
#
#     # frozen_time.
#     #   strftime(StrMsgs::TIME_FORMAT).strip
#
#     expect(page).to have_content "Bob's peep"
#   end


feature 'User can create a peep', :db do
  scenario 'User can create a peep' do
    # setup
    frozen_time = Timecop.freeze(Time.now)
    user = User.create('Bob', 'bob@bob', 'pswd')
    sign_up

    peep_text = "Bob's peep"
    create_peep peep_text
    peep = Peep.create(user.id, peep_text)

    pp peep


    # expect(page).to have_css('tr > nth-') peep.html
  end
end

# feature 'User can create a peep', :db do
#   scenario 'it can be created' do
#     peep = Peep.new(id: 5, user_id: 3, text: "Bob's peep", created_at: Time.now)
#     expect(rendered)
#     puts peep.html
#   end
# end
