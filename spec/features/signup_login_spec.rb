require 'spec_helper'
require 'capybara/rails'
require 'sidekiq/testing'

feature 'Signup' do

  before (:each) do
    Sidekiq::Testing.fake!
    signup('user@example.com', 'password')
  end

  after (:each) do
    delete_user('user@example.com')
  end

  scenario "sign in or login goes to home page" do
    expect(page).to have_content("Enter Profile Information")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    expect(page).to have_content("Login")
    expect(page).to have_content("You need to login or sign up before continuing.")
    login('user@example.com','password')
    expect(page).to have_content("Enter Profile Information")
    expect(page).to have_content("Logged in as user@example.com.")
    expect(page).to have_content("Logged in successfully.")
  end

  scenario "user cannot sign up with an email already in use" do
    expect(page).to have_content("Enter Profile Information")
    expect(page).to have_content("Welcome! You have signed up successfully.")
    click_link "Logout"
    signup('user@example.com', 'password')
    expect(page).to have_content("1 error prohibited this user from being saved: Email has already been taken")
  end

end