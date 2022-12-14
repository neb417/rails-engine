require 'rails_helper'

RSpec.describe 'Updating Item' do
  let!(:merchant) { create(:merchant) }
  let!(:item) { create(:item, merchant_id: merchant.id) }

  it 'updates the item' do
    item_params = {
      name: 'Thingy',
      description: 'Does a thing',
      unit_price: 12.34,
      merchant_id: merchant.id
    }

    headers = {'CONTENT_TYPE' => 'application/json'}

    patch api_v1_item_path(item[:id]), headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(Item.all.first.name).to eq(item_params[:name])
  end

  it 'edge case: error when merch id is not valid' do
    item_params = {
      name: 'Thingy',
      description: 'Does a thing',
      unit_price: 12.34,
      merchant_id: nil
    }

    headers = {'CONTENT_TYPE' => 'application/json'}

    patch api_v1_item_path(item[:id]), headers: headers, params: JSON.generate(item: item_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
