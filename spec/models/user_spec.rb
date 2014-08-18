require 'spec_helper'

describe User do

  before :each do
    @user = FactoryGirl.build(:user)
  end

  describe "email" do

    it "should accept valid email format" do
      expect(@user).to be_valid
    end

    it "should not be empty" do
      user = FactoryGirl.build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it "should be unique" do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.build(:user, email: user1.email)
      expect(user2).not_to be_valid
    end

    it "should reject invalid email format" do
      user = FactoryGirl.build(:user, email: '123.com')
      expect(user).not_to be_valid
    end

  end

  describe "password" do

    it "should change password" do
      @user.password = "newpassword"
      @user.password_confirmation = "newpassword"
      @user.save
      expect(@user).to be_valid
    end

    it "should not change password - too short" do
      @user.password = "short"
      @user.password_confirmation = "short"
      @user.save
      expect(@user).not_to be_valid
    end

    it "should not be valid password does not exist" do
      @user.password = nil
      @user.save
      expect(@user).not_to be_valid
    end

    it "should not be valid password_confirmation does match" do
      @user.password_confirmation = 'no_match'
      @user.save
      expect(@user).not_to be_valid
    end

  end

end