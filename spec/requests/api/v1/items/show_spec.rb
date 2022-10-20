require 'rails_helper'

RSpec.describe 'Item Show API' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

  describe 'item show' do
    before :each do
      get api_v1_item_path(item_list.first[:id])
    end

    it 'returns successful connection' do
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'pass correct JSON format' do
      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      expect(item[:type]).to eq('item')
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)
    end
  end
end