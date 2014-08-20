require 'capybara/rails'

feature 'Session' do

  before (:each) do
    signup('user@example.com', 'password')
  end

  after (:each) do
    delete_user('user@example.com')
  end

  scenario "user can create and edit a profile" do
    expect(page).to have_content("Landing#index")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_content("Create Profile")

    click_link "Create Profile"
    expect(page).to have_content("Enter Profile Information")
    fill_in "First name", with: "Mickey"
    fill_in "Last name", with: "Mouse"
    fill_in "Address", with: "2741 Leolani Place"
    fill_in "City", with: "Makawao"
    fill_in "State", with: "HI"
    fill_in "Zipcode", with: "96768"
    fill_in "Phone", with: "8082803758"
    fill_in "Function", with: "Recycler"
    click_on "Create Profile"
    expect(page).to have_content("Profile Show Page")
    expect(page).to have_content("First name: Mickey")
    expect(page).to have_content("Last name: Mouse")
    expect(page).to have_content("Address: 2741 Leolani Place")
    expect(page).to have_content("City: Makawao")
    expect(page).to have_content("State: HI")
    expect(page).to have_content("Zipcode: 96768")
    expect(page).to have_content("Phone: 8082803758")
    expect(page).to have_content("Function: Recycler")
    expect(page).to have_content("Edit Profile")

    click_link "Edit Profile"
    expect(page).to have_content("Edit Profile Page")
    expect(page).to have_content("First name")
    fill_in "First name", with: "Minnie"

    click_on "Update Profile"
    expect(page).to have_content("Profile Show Page")
    expect(page).to have_content("First name: Minnie")




  end

end