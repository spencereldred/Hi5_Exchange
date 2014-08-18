require 'spec_helper'

describe Profile do

  it "should create a valid profile" do
    profile = Profile.create(address: '2741 Leolani Place', city: 'Makawao', state: 'HI', zipcode: '96768')
    expect(profile).to be_valid
  end

end
