require 'capybara/rails'

feature 'Session' do

  before (:each) do
    signup('user@example.com', 'password')
  end

  after (:each) do
    delete_user('user@example.com')
  end

  scenario "sign in or login goes to home page" do
    expect(page).to have_content("Landing Page")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    expect(page).to have_content("Login")
    expect(page).to have_content("You need to login or sign up before continuing.")
    login('user@example.com','password')
    expect(page).to have_content("Landing Page")
    expect(page).to have_content("Logged in as user@example.com.")
    expect(page).to have_content("Logged in successfully.")
  end

  scenario "user cannot sign up with an email already in use" do
    expect(page).to have_content("Landing Page")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    signup('user@example.com', 'password')
    expect(page).to have_content("1 error prohibited this user from being saved: Email has already been taken")
  end

  def signup(email, password)
    visit new_user_session_path
    click_link "Sign up"
    expect(page).to have_content("Password confirmation")
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_button "Sign up"
  end

  def login(email, password)
    fill_in "Email", with: email
    fill_in "Password", with: password
    click_button "Login"
  end

  def delete_user(email)
    User.find_by(email: email).delete
  end

end