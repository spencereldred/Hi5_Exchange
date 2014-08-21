require 'spec_helper'

describe UserRecyclable do

  before (:each) do
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @profile = Profile.create(user_id: @user.id, first_name: 'Spencer', last_name: 'Eldred', address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768', function: 'redeemer')
  end

  after (:each) do
    @user.destroy
  end

  it "user can retrieve a recyclable through relationship" do
    recyclable = Recyclable.create(trans_type: "redeemable", plastic: 1)
    UserRecyclable.create(user_id: @user.id, recyclable_id: recyclable.id)
    expect(@user.recyclables[0].plastic).to eq(1)
    expect(@user.recyclables[0].trans_type).to eq("redeemable")
  end

end