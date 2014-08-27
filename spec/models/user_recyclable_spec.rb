require 'spec_helper'

describe UserRecyclable do

  before (:all) do
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @profile = Profile.create(user_id: @user.id, first_name: 'Spencer', last_name: 'Eldred', address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768', function: 'redeemer')
    @recyclable = Recyclable.create(trans_type: "redeemable", plastic: 1, user_id: @user.id)
    @user_recyclable = UserRecyclable.create(user_id: @user.id, recyclable_id: @recyclable.id)

  end

  after (:all) do
    @user.destroy
  end

  it "user can retrieve a recyclable through relationship" do
    expect(@user.recyclables[0].plastic).to eq(1)
    expect(@user.recyclables[0].trans_type).to eq("redeemable")
  end

  it { expect(@user_recyclable).to be_valid }

  it "should be invalid without user_id" do
    @user_recyclable.user_id = ""
    expect(@user_recyclable).not_to be_valid
    @user_recyclable.user_id = "@user.id"
  end

  it "should be invalid without recyclable_id" do
    @user_recyclable.recyclable_id = ""
    expect(@user_recyclable).not_to be_valid
    @user_recyclable.recyclable_id = "@recyclable.id"
  end

end