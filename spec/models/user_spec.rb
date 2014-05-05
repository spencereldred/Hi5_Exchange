require 'spec_helper'

describe User do 

  before :each do 
    @user = FactoryGirl.build(:user)
  end 

  describe "email" do 

    it "should accept valid email format" do 
      @user.should be_valid 
    end

    it "should not be empty" do
      user = FactoryGirl.build(:user, email: nil)
      user.should_not be_valid   
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

  describe "password" do 

    it "should change password" do 
      @user.password = "newpassword"
      @user.password_confirmation = "newpassword"
      @user.save
      @user.should be_valid
    end

    it "should not change password - too short" do 
      @user.password = "short"
      @user.password_confirmation = "short"
      @user.save
      @user.should_not be_valid
    end

    it "should not be valid password does not exist" do  
      @user.password = nil
      @user.save
      @user.should_not be_valid
    end

    it "should not be valid password_confirmation does match" do  
      @user.password_confirmation = 'no_match'
      @user.save
      @user.should_not be_valid
    end


  end

end