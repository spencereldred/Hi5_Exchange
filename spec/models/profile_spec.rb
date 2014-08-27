require 'spec_helper'

describe Profile do

  before (:all) do
    sleep(1)
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @profile = Profile.create(user_id: @user.id, first_name: 'Spencer', last_name: 'Eldred', address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768', function: 'redeemer')
  end

  after (:all) do
    @user.destroy
  end

  subject { @profile }

  it { expect(@profile).to be_valid }
  it { expect(@profile).to respond_to(:address) }
  it { expect(@profile).to respond_to(:city) }
  it { expect(@profile).to respond_to(:state) }
  it { expect(@profile).to respond_to(:zipcode) }
  it { expect(@profile).to respond_to(:user_id) }
  it { expect(@profile).to respond_to(:phone) }
  it { expect(@profile).to respond_to(:function) }
  it { expect(@profile).to respond_to(:longitude) }
  it { expect(@profile).to respond_to(:latitude) }

  it { expect(@profile.latitude).to eq(20.8364945) }
  it { expect(@profile.longitude).to eq(-156.3535161) }

  it "requires 'address' to be valid" do
    @profile.address = ""
    expect(@profile).not_to be_valid
    @profile.address = "2741 Leolani Place"
  end

  it "requires 'city' to be valid" do
    @profile.city = ""
    expect(@profile).not_to be_valid
    @profile.city = "Makawao"
  end

  it "requires 'state' to be valid" do
    @profile.state = ""
    expect(@profile).not_to be_valid
    @profile.state = "HI"
  end

  it "requires 'zipcode' to be valid" do
    @profile.zipcode = ""
    expect(@profile).not_to be_valid
    @profile.zipcode = "96768"
  end

  it "requires 'function' to be valid" do
    @profile.function = ""
    expect(@profile).not_to be_valid
    @profile.function = "redeemer"
  end

end
