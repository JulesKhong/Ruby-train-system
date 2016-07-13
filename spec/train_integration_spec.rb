require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a train', {:type => :feature}) do
  it('adds a train to the list of trains') do
    visit('/')
    fill_in('name', :with => 'Thomas')
    click_button('Add train')
    expect(page).to have_content('Success!')
  end
end

describe('displaying a list of trains once they have been created', {:type => :feature}) do
  it('reads back a list of trains') do
  visit('/')
  fill_in('name', :with => 'Thomas')
  click_button('Add train')
  click_link('Return to dashboard')
  expect(page).to have_content('Thomas')
  end
end
