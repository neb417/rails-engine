require 'rails_helper'

RSpec.describe 'Merchant Index API' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:merchant1) { merchant_list.first }

  describe 'merchants index' do
    before(:each) do
      get api_v1_merchants_path
    end

    it 'response is successful' do
      expect(response).to be_successful
      expect(response.status).to eq(200)
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
end