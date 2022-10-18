require 'rails_helper'

RSpec.describe "Merchant's Items API" do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

  before(:each) do
    get api_v1_merchant_items_path(merchant_list.first)
  end

  it 'returns successful response' do
    expect(response).to be_successful
  end

  it 'returns API in JSON format' do
    items = JSON.parse(response.body, symbolize_names: true)[:data]

    items.each do |item|
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