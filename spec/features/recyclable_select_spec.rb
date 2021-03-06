require 'spec_helper'
require 'capybara/rails'
require 'sidekiq/testing'

feature 'Update Transaction' do

  before (:each) do
    Sidekiq::Testing.fake!
    # Freeze today to 8/28/2014, calculate date from there
    date = Time.local(2014, 8, 28, 0, 0, 0)
    Timecop.travel(date)
    create_selectable_transactions

    visit new_user_session_path
    fill_in "Email", with: 'eldredspencer@gmail.com'
    fill_in "Password", with: 'password'
    click_button "Login"

  end

  after (:each) do
    delete_users_and_transactions
    # release the Timecop
    Timecop.return
  end


  scenario "redeemer can select a transaction", js: true do
    # visit new_user_session_path

    # fill_in "Email", with: 'eldredspencer@gmail.com'
    # fill_in "Password", with: 'password'
    # save_and_open_page
    # click_button "Login"

    expect(page).to have_content("Redeemers#index")
    expect(page).to have_content("Logged in successfully.")
    expect(page).to have_content("Available Redeemable Transactions Select 1062 Delaware St., Denver: Plastic: 1 Glass: 1 Cans: 1 Mixed Hi5: 1 Posted: 08/28 12:00")
    expect(page).not_to have_content("268 St. Charles Ave., San Francisco: Plastic: 3 Glass: 3 Cans: 3 Mixed Hi5: 3")
    expect(page).to have_content("Available Good Samaritan Transactions Select 1062 Delaware St., Denver: Cardboard Newspaper Magazines Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans Posted: 08/28 12:00")
    expect(page).not_to have_content("268 St. Charles Ave., San Francisco: Cardboard Paper Non_hi5_plastic Non_hi5_glass")
    # expect(page).to have_button("Select")

    within(first(".redeemable")) do
      click_on "Select"
    end

    # expect(page).to have_content("Redeemable transaction has been selected!")
    expect(page).not_to have_content("Available Redeemable Transactions 1062 Select Delaware St., Denver: Plastic: 1 Glass: 1 Cans: 1 Mixed Hi5: 1 Posted: 08/28 12:00")
    expect(page).to have_content("Selected Redeemable Transactions 1062 Delaware St., Denver: Plastic: 1 Glass: 1 Cans: 1 Mixed Hi5: 1 Selected: 08/28 12:00 Completed")

    within(first(".samaritan")) do
      click_on "Select"
    end
    # expect(page).to have_content("Good Samaritan transaction has been selected!")
    expect(page).not_to have_content("Available Good Samaritan Transactions 1062 Delaware St., Denver: Cardboard Newspaper Magazines Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans Posted: 08/28 12:00")
    expect(page).to have_content("Selected Good Samaritan Transactions 1062 Delaware St., Denver: Cardboard Newspaper Magazines Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans Selected: 08/28 12:00 Completed")

    # expect(page).to have_button("Completed")

    within(first(".redeemable_selected")) do
      click_on "Completed"
    end
    # expect(page).to have_content("Redeemable transaction has been completed!")
    expect(page).not_to have_content("Selected Redeemable Transactions 1062 Delaware St., Denver: Plastic: 1 Glass: 1 Cans: 1 Mixed Hi5: 1 Selected: 08/28 12:00 Completed")

    within(first(".samaritan_selected")) do
      click_on "Completed"
    end
    # expect(page).to have_content("Good Samaritan transaction has been completed!")
    expect(page).not_to have_content("Selected Good Samaritan Transactions 1062 Delaware St., Denver: Cardboard Newspaper Magazines Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans Selected: 08/28 12:00 Completed")

  end

end

