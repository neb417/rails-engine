require 'rails_helper'

RSpec.describe 'Non_ReSTful find_all items' do
  let!(:item_list) { create_list(:item, 50) }

  it 'response is successful' do
    find_params = { name: 'in' }

    get api_v1_items_find_all_path, params: find_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'returns items by name' do
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

  it 'returns items by min_price' do
    min_price = { min_price: 140.0 }
    get api_v1_items_find_all_path, params: min_price

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.count).to be < Item.all.count
  end

  it 'returns items by max_price' do
    max_price = { max_price: 140.0 }

    get api_v1_items_find_all_path, params: max_price

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.count).to be < Item.all.count
  end

  it 'returns items by price_range' do
    price_range = { min_price: 140, max_price: 240 }

    get api_v1_items_find_all_path, params: price_range

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(items.count).to be < Item.all.count
  end

  it 'min_price less than 0' do
    min_price = { min_price: -5 }
    get api_v1_items_find_all_path, params: min_price

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'max_price less than 0' do
    max_price = { min_price: -5 }
    get api_v1_items_find_all_path, params: max_price

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'errors when name and min_price passed in' do
    params = { name: 'o', min_price: 14.0 }

    get api_v1_items_find_all_path, params: params

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'errors when name and max_price passed in' do
    params = { name: 'o', max_price: 14.0 }

    get api_v1_items_find_all_path, params: params

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'errors when min_price > max_price' do
    price_range = { min_price: 240, max_price: 140 }

    get api_v1_items_find_all_path, params: price_range

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end