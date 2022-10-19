require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

  describe 'items index' do
    before :each do
      get api_v1_items_path
    end

    it 'returns successful response' do
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'pass correct JSON format' do
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

  describe 'POST an item' do
    it 'posts to items' do
      merchant = create(:merchant)

      items_count = Item.all.count

      item_params = ({
        name: 'Thingy',
        description: 'Does a thing',
        unit_price: 12.34,
        merchant_id: merchant.id
      })

      headers = {"CONTENT_TYPE" => 'application/json'}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(Item.all.count).to eq(items_count + 1)
    end

    it 'has error if attribute is missing' do
      merchant = create(:merchant)

      items_count = Item.all.count

      item_params = ({
        description: 'Does a thing',
        unit_price: 12.34,
        merchant_id: merchant.id
      })

      headers = {"CONTENT_TYPE" => 'application/json'}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      item_params = ({
        name: 'Thingy',
        unit_price: 12.34,
        merchant_id: merchant.id
      })

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      item_params = ({
        name: 'Thingy',
        description: 'Does a thing',
        merchant_id: merchant.id
      })

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      item_params = ({
        name: 'Thingy',
        description: 'Does a thing',
        unit_price: 12.34
      })

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
    end

    it 'ignores other attributes passed in' do
      merchant = create(:merchant)

      items_count = Item.all.count

      item_params = ({
        name: 'Thingy',
        description: 'Does a thing',
        unit_price: 12.34,
        merchant_id: merchant.id,
        something_else: 'String'
      })

      headers = {"CONTENT_TYPE" => 'application/json'}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      first = Item.first
      item = Item.last

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(Item.all.count).to eq(items_count + 1)
      expect(item.attributes.count).to eq(first.attributes.count)
    end
  end
end