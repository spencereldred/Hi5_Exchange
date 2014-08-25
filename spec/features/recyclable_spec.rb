require 'capybara/rails'

feature 'Recyclable' do

  before (:each) do
    # TODO: add users from other states to test geocoding
    create_users_and_transactions
  end

  after (:each) do
    delete_users_and_transactions
  end


  scenario "recycler can view open transactions" do
    visit new_user_session_path
    fill_in "Email", with: 'rec1_co@example.com'
    fill_in "Password", with: 'password'
    click_button "Login"
    expect(page).to have_content("Recyclers#index")
    expect(page).to have_content("Open Recyclable Transactions")
    expect(page).to have_content("Plastic: 1")
    expect(page).to have_content("Glass: 1")
    expect(page).to have_content("Cans: 1")
    expect(page).to have_content("Mixed Hi5: 1")
    expect(page).to have_content("Open Good Samaritan Transactions")
    expect(page).to have_content("Cardboard")
    expect(page).to have_content("Newspaper")
    expect(page).to have_content("Magazines")
    expect(page).to have_content("Paper")
    expect(page).to have_content("Non_hi5_plastic")
    expect(page).to have_content("Non_hi5_glass")
    expect(page).to have_content("Non_hi5_cans")

    click_button "Create New Transaction"
    expect(page).to have_content("Create Redeemable Transaction")
    expect(page).to have_content("Create Good Samaritan Transaction")
    select "5 bags", from: "recyclable[plastic]"
    select "4 bags", from: "recyclable[glass]"
    select "3 bags", from: "recyclable[cans]"
    select "2 bags", from: "recyclable[other]"
    click_on "Create Redeemable Transaction"
    expect(page).to have_content("Open Recyclable Transactions")
    expect(page).to have_content("Plastic: 5")
    expect(page).to have_content("Glass: 4")
    expect(page).to have_content("Cans: 3")
    expect(page).to have_content("Mixed Hi5: 2")

    click_button "Create New Transaction"
    expect(page).to have_content("Create Redeemable Transaction")
    expect(page).to have_content("Create Good Samaritan Transaction")
    check("Cardboard")
    check("Newspaper")
    check("Magazines")
    check("Paper")
    check("Non hi5 plastic")
    check("Non hi5 glass")
    check("Non hi5 cans")
    click_on "Create Samaritan Transaction"
    expect(page).to have_content("Open Good Samaritan Transactions")
    expect(page).to have_content("Cardboard")
    expect(page).to have_content("Newspaper")
    expect(page).to have_content("Magazines")
    expect(page).to have_content("Paper")
    expect(page).to have_content("Non_hi5_plastic")
    expect(page).to have_content("Non_hi5_glass")
    expect(page).to have_content("Non_hi5_cans")

  end

  scenario "redeemer can select a transaction" do
    visit new_user_session_path
    fill_in "Email", with: 'red1_co@example.com'
    fill_in "Password", with: 'password'
    click_button "Login"
    expect(page).to have_content("Redeemers#index")
    expect(page).to have_content("Available Redeemable Transactions")
    expect(page).to have_content("Plastic: 1")
    expect(page).to have_content("1062 Delaware St.")
    expect(page).to have_content("Available Good Samaritan Transactions")
    expect(page).to have_content("Cardboard")


  end

end