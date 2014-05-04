require 'spec_helper'

describe 'Landing Page' do   
  
  it 'should be a valid response' do
    get "/" 
    expect(response.status).to eq(200) 
  end

  it 'should render template index' do 
    get "/" 
    expect(response).to render_template(:index)
  end

  it 'should include "Landing" on the page' do 
    get "/" 
    expect(response.body).to include("Landing")
  end

end
