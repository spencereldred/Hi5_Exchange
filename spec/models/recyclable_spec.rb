require 'spec_helper'

describe Recyclable do

  before (:all) do
    sleep(1)
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @profile = Profile.create(user_id: @user.id, first_name: 'Spencer', last_name: 'Eldred', address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768', function: 'redeemer')
    @recyclable = Recyclable.create(trans_type: "redeemable", plastic: 1, user_id: @user.id)
    sleep(1)
  end

  after (:all) do
    User.destroy_all
    Recyclable.destroy_all
    # @user.destroy
  end

  it { expect(@recyclable).to be_valid }

  it "should be invalid without trans_type" do
    @recyclable.trans_type = ""
    expect(@recyclable).not_to be_valid
    @recyclable.trans_type = "redeemable"
  end


end