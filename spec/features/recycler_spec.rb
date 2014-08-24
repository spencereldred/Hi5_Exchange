require 'capybara/rails'

feature 'Recycler' do

  before (:all) do
    @rec1_co = User.create(
      email: 'rec1_co@example.com', password: 'password',
      password_confirmation: 'password')

    @rec1_co_profile = Profile.create(
      user_id: @rec1_co.id, first_name: 'Joe-recycler', last_name: 'Colorado',
      address: '1062 Delaware St.', city: 'Denver', state: 'CO',
      zipcode: '80204', phone: '8082803758',function: 'recycler')

    @red1_co = User.create(
      email: 'red1_co@example.com', password: 'password',
      password_confirmation: 'password')

    @red1_co_profile = Profile.create(
      user_id: @red1_co.id, first_name: 'Joe-redeemer', last_name: 'Colorado',
      address: '460 Humboldt St.', city: 'Denver', state: 'CO',
      zipcode: '80209', phone: '8082803758',function: 'redeemer')

    @co_recyclable1 = Recyclable.create(trans_type: "redeemable", plastic: 1,
      cans: 1, glass: 1, other: 1)

    @co_recyclable2 = Recyclable.create(trans_type: "samaritan", cardboard: true,
      non_hi5_plastic: true, non_hi5_cans: true, non_hi5_glass: true,
      magazines: true, paper: true, newspaper: true)

    @user_recyclable1 = UserRecyclable.create(user_id: @rec1_co.id,
      recyclable_id: @co_recyclable1.id, redeemer_id: @red1_co.id)

    @user_recyclable2 = UserRecyclable.create(user_id: @rec1_co.id,
      recyclable_id: @co_recyclable2.id, redeemer_id: @red1_co.id)

  end

  after (:all) do
    User.delete(@rec1_co.id)
    User.delete(@red1_co.id)
    Profile.delete(@rec1_co_profile.id)
    Profile.delete(@red1_co_profile.id)
    Recyclable.delete(@co_recyclable1.id)
    Recyclable.delete(@co_recyclable2.id)
    UserRecyclable.delete(@user_recyclable1.id)
    UserRecyclable.delete(@user_recyclable2.id)
  end


  scenario "recycler can view open transactions" do
    visit new_user_session_path
    fill_in "Email", with: 'rec1_co@example.com'
    fill_in "Password", with: 'password'
    click_button "Login"
    expect(page).to have_content("Recyclers#index")
    expect(page).to have_content("Open Recyclable Transactions")
    expect(page).to have_content("Plastic: 1")
    expect(page).to have_content("Open Good Samaritan Transactions")
    expect(page).to have_content("Cardboard")

    click_button "Create New Transaction"
    expect(page).to have_content("Create Redeemable Transaction")
    expect(page).to have_content("Create Good Samaritan Transaction")
  end


end