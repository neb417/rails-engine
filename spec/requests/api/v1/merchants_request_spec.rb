require 'rails_helper'

RSpec.describe "Merchants API" do
  let!(:merchants) {create_list(:merchant, 3)}
  describe 'all merchants' do
    before :each do
      get '/api/v1/merchants'
    end

    it "response is successful" do
      expect(response).to be_successful
    end
  end
end