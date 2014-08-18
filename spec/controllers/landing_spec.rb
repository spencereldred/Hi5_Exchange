require 'spec_helper'

describe 'Requests' do
  describe 'Landing Page' do

    before(:each) do
      get '/'
    end

    xit 'should be a valid response' do
      expect(response.status).to eq(200)
    end

    xit 'should render template index' do
      expect(response).to render_template(:index)
    end

    xit 'should include "Landing" on the page' do
      expect(response.body).to include("Landing")
    end

  end
end
