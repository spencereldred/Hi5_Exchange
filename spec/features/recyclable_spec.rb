require 'spec_helper'
require 'capybara/rails'
require 'sidekiq/testing'

feature 'Create Transaction' do

  before (:each) do
    Sidekiq::Testing.fake!
    # Freeze today to 8/28/2014, calculate date from there
    date = Time.local(2014, 8, 28, 9, 0, 0)
    Timecop.freeze(date)
    create_users_and_transactions
  end

  after (:each) do
    delete_users_and_transactions
    # release the Timecop
    Timecop.return
  end


  scenario "recycler can view open transactions" do
    visit new_user_session_path
    fill_in "Email", with: 'rec1@example.com'
    fill_in "Password", with: 'password'
    click_button "Login"
    expect(page).to have_content("Recyclers#index")
    expect(page).to have_content("Logged in successfully.")
    expect(page).to have_content("Open Recyclable Transactions")
    expect(page).to have_content("Plastic: 1 Glass: 1 Cans: 1 Mixed Hi5: 1")
    expect(page).to have_content("Plastic: 2 Glass: 2 Cans: 2 Mixed Hi5: 2 Selected: 29 Aug")
    expect(page).not_to have_content("Plastic: 3 Glass: 3 Cans: 3 Mixed Hi5: 3 Selected")
    expect(page).to have_content("Open Good Samaritan Transactions")
    expect(page).to have_content("Cardboard Newspaper Magazines Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans")
    expect(page).to have_content("Cardboard Newspaper Magazines Paper Selected: 29 Aug")
    expect(page).not_to have_content("Non_hi5_plastic Non_hi5_glass Non_hi5_cans Selected")

    click_button "Create New Transaction"
    expect(page).to have_content("Create Redeemable Transaction")
    expect(page).to have_content("Create Good Samaritan Transaction")
    select "5 bags", from: "recyclable[plastic]"
    select "4 bags", from: "recyclable[glass]"
    select "3 bags", from: "recyclable[cans]"
    select "2 bags", from: "recyclable[other]"
    click_on "Create Redeemable Transaction"

    # save_and_open_page

    expect(page).to have_content("Redeemable transaction has been created!")
    expect(page).to have_content("Open Recyclable Transactions ")
    expect(page).to have_content("Plastic: 5 Glass: 4 Cans: 3 Mixed Hi5: 2")

    click_button "Create New Transaction"
    expect(page).to have_content("Create Redeemable Transaction")
    expect(page).to have_content("Create Good Samaritan Transaction")
    check("Cardboard")
    check("Newspaper")
    # check("Magazines")
    check("Paper")
    check("Non hi5 plastic")
    check("Non hi5 glass")
    check("Non hi5 cans")
    click_on "Create Samaritan Transaction"

    expect(page).to have_content("Samaritan transaction has been created!")
    expect(page).to have_content("Open Good Samaritan Transactions ")
    expect(page).to have_content("Cardboard Newspaper Paper Non_hi5_plastic Non_hi5_glass Non_hi5_cans")


    # save_and_open_page
  end


end