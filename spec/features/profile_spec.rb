require 'spec_helper'
require 'capybara/rails'
require 'sidekiq/testing'

feature 'Create and Update Profile' do

  before (:each) do
    Sidekiq::Testing.fake!
    sleep(1)
    signup('user@example.com', 'password')
    sleep(1)
  end

  after (:each) do
    delete_user('user@example.com')
  end

  scenario "user can create and edit a profile" do
    expect(page).to have_content("Enter Profile Information")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    fill_in "First name", with: "Mickey"
    fill_in "Last name", with: "Mouse"
    fill_in "Address", with: "2741 Leolani Place"
    fill_in "City", with: "Makawao"
    fill_in "State", with: "HI"
    fill_in "Zipcode", with: "96768"
    fill_in "Phone", with: "8082803758"
    select "recycler", from: "profile[function]"

    click_on "Create Profile"
    expect(page).to have_content("Profile was created successfully!")
    # expect(page).to have_content("Profile Show Page")
    # expect(page).to have_content("First name: Mickey")
    # expect(page).to have_content("Last name: Mouse")
    # expect(page).to have_content("Address: 2741 Leolani Place")
    # expect(page).to have_content("City: Makawao")
    # expect(page).to have_content("State: HI")
    # expect(page).to have_content("Zipcode: 96768")
    # expect(page).to have_content("Phone: 8082803758")
    # expect(page).to have_content("Function: recycler")
    # expect(page).to have_content("Edit Profile")

    # click_link "Home"
    # visit root_path

    click_link "Edit Profile"
    expect(page).to have_content("Edit Profile Page")
    expect(page).to have_content("First name")
    fill_in "First name", with: "Minnie"

    click_on "Update Profile"
    expect(page).to have_content("Profile was successfully updated!")
    # 9/6 edit: after profile update - redirecting user to home page not to
    # profile show page
    # expect(page).to have_content("Profile Show Page")
    # expect(page).to have_content("First name: Minnie")
    # expect(page).to have_content("Home")

    # click_link "Home"
    # redirect to recycler function page
    expect(page).to have_content("Recyclers#index")
    expect(page).to have_content("Edit Profile")

    click_link "Edit Profile"
    expect(page).to have_content("Edit Profile Page")
    expect(page).to have_content("First name")
    expect(page).to have_content("Home")

    # click_link "Home"
    visit root_path
    expect(page).to have_content("Recyclers#index")

    click_link "Edit Profile"
    expect(page).to have_content("Edit Profile Page")
    expect(page).to have_content("First name")
    fill_in "First name", with: ""

    click_on "Update Profile"
    expect(page).to have_content("Profile could not be updated")
    expect(page).to have_content("Edit Profile Page")

  end

  scenario "user cannot create incomplete profile" do
    expect(page).to have_content("Enter Profile Information")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    fill_in "First name", with: "Mickey"
    fill_in "Last name", with: "Mouse"

    click_on "Create Profile"
    expect(page).to have_content("Your profile could not be created.")
    expect(page).to have_content("Enter Profile Information")
  end

end