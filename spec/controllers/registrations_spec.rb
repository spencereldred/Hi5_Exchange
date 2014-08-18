require 'spec_helper'

describe 'Requests' do
  describe 'new registration page' do
    before(:each) do
      get "/users/sign_up"
    end

    xit "should have valid response" do
      expect(response.status).to eq(200)
    end

    xit 'should render template new' do
      expect(response).to render_template(:new)
    end

    xit 'should include "Sign up" on the page' do
      expect(response.body).to include("Sign up")
    end


  end



end
