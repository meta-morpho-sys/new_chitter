# frozen_string_literal: true

feature 'The app starts' do
  it 'should pass' do
    p ENV['RACK_ENV']
    expect(true).to be true
  end

  it 'by showing some text when launched' do
    visit '/'
    expect(page).to have_content 'lets start'
  end
end
