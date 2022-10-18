require 'rails_helper'

RSpec.describe "Merchants API" do
  let!(:merchant_list) {create_list(:merchant, 10)}

  describe 'merchants index' do
    before(:each) do
      get '/api/v1/merchants'
      # merchants = JSON.parse(response.body, symbolize_names: true)
    end

    it "response is successful" do
      expect(response).to be_successful
    end

    it 'has correct count of merchants' do
      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(10)
    end

    it 'has correct attributes' do
      merchants = JSON.parse(response.body, symbolize_names: true)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(Integer)
        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end
  end
end