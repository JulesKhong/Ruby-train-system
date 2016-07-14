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
  it('turns list item into a link that leads to a train page') do
    visit('/')
    fill_in('name', :with => 'Thomas')
    click_button('Add train')
    click_link('Return to dashboard')
    click_link('Thomas')
    expect(page).to have_content('Delete Thomas')
  end
end

describe('allows user to delete a train they have added', {:type => :feature}) do
  it('adds a train to the list of trains, then deletes it') do
    visit('/')
    fill_in('name', :with => 'Thomas')
    click_button('Add train')
    click_link('Return to dashboard')
    fill_in('name', :with => 'Freight')
    click_button('Add train')
    click_link('Return to dashboard')
    click_link('Thomas')
    click_button('Delete Thomas')
    expect(page).to have_no_content('Thomas')
  end
end

describe('adding a city', {:type => :feature}) do
  it('adds a city stop to the list of cities') do
    visit('/')
    fill_in('name', :with => 'Thomas')
    click_button('Add train')
    click_link('Return to dashboard')
    click_link('Thomas')
    fill_in('city-name', :with => "Tokyo")
    click_button('Add Stop')
    click_link('Thomas')
    expect(page).to have_content('Tokyo')
  end
end
