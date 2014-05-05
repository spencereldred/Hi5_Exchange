require 'spec_helper'

describe 'Requests' do 
  describe 'new registration page' do 
    before(:each) do  
      get "/users/sign_up"
    end 

    it "should have valid response" do 
      expect(response.status).to eq(200) 
    end

    it 'should render template new' do 
      expect(response).to render_template(:new)
    end

    it 'should include "Sign up" on the page' do 
      expect(response.body).to include("Sign up")
    end


  end

  

end
