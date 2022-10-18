require 'rails_helper'

RSpec.describe "Merchants API" do
  let!(:merchant_list) {create_list(:merchant, 10)}

  describe 'merchants index' do
    before(:each) do
      get '/api/v1/merchants'
    end

    it 'response is successful' do
      expect(response).to be_successful
    end

    it 'has correct count of merchants and attributes' do
      merchants = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(merchants.count).to eq(10)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(String)
        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end

  describe 'merchant show' do
    before(:each) do
      get "/api/v1/merchants/#{merchant_list.first[:id]}"
    end

    it 'response is successful' do
      expect(response).to be_successful
    end

    it 'requests only one merchant' do
      merchant = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end

    xit 'returns 4xx' do
      get "/api/v1/merchants/#{merchant_list.last[:id] + 1}"

      expect(resonse.status).to eq(404)
    end
  end
end