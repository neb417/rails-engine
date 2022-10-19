require 'rails_helper'

RSpec.describe 'Non_ReSTful find_all items' do
  let!(:item_list) { create_list(:item, 50) }

  it 'response is successful' do
    find_params = { name: 'in' }

    get api_v1_items_find_all_path, params: find_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'returns items' do
    find_params = { name: 'in' }

    get api_v1_items_find_all_path, params: find_params

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