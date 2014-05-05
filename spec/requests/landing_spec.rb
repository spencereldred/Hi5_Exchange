require 'spec_helper'

describe 'Requests' do 
  describe 'Landing Page' do 

    before(:each) do  
      get "/"
    end  
    
    it 'should be a valid response' do
      expect(response.status).to eq(200) 
    end

    it 'should render template index' do 
      expect(response).to render_template(:index)
    end

    it 'should include "Landing" on the page' do 
      expect(response.body).to include("Landing")
    end

  end
end
