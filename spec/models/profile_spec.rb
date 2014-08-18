require 'spec_helper'

describe Profile do

  before (:each) do
    @user = User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @profile = Profile.create(user_id: @user.id, address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768')
  end

  after (:each) do
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

end
