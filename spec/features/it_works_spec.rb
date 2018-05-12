# frozen_string_literal: true

feature 'The app starts' do
  scenario 'by showing some text when launched' do
    visit '/'
    expect(page).to have_content 'lets start'
  end
end
