require 'capybara/rails'

feature 'Task lists' do

  before do
    visit new_user_session_path
    click_link "Sign up"
    expect(page).to have_content("Password confirmation")
    fill_in "Email", with: 'user@example.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Sign up"


  end

  after do

  end

  scenario "login goes to home page" do
    expect(page).to have_content("Landing Page")
    expect(page).to have_content("Welcome! You have signed up successfully.")



  end



end