require 'rails_helper'

RSpec.describe 'Items POST API' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

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