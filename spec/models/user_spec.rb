require 'spec_helper'

describe User do  

  describe "email" do 

    before :each do 
      @user = FactoryGirl.build(:user)
    end

    it "should not be empty" do
      user = FactoryGirl.build(:user, email: nil)
      user.should_not be_valid   
    end

    it "should accept valid email format" do 
      user = FactoryGirl.build(:user)
      user.should be_valid 
    end

    it "should be unique" do 
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.build(:user, email: user1.email)
      user2.should_not be_valid 
    end

    it "should reject invalid email format" do 
      user = FactoryGirl.build(:user, email: '123.com')
      user.should_not be_valid 
    end

  end

end