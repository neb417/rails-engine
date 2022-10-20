require 'rails_helper'

RSpec.describe 'Merchant Show API' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:merchant1) { merchant_list.first }

  describe 'merchant show' do
    before(:each) do
      get api_v1_merchant_path(merchant1[:id])
    end

    it 'response is successful' do
      expect(response).to be_successful
      expect(response.status).to eq(200)
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

    xit 'edge case: returns 404' do
      get api_v1_merchant_path(merchant_list.last[:id].to_s)

      expect(response.status).to eq(404)
    end
  end
end