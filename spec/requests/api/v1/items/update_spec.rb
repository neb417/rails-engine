require 'rails_helper'

RSpec.describe 'Updating Item' do
  let!(:merchant) { create(:merchant) }
  let!(:item_list) { create_list(:item, 5, merchant_id: merchant.id) }

  it 'updates the item' do
    item_params = ({
      name: 'Thingy',
      description: 'Does a thing',
      unit_price: 12.34,
      merchant_id: merchant.id
    })

    headers = {"CONTENT_TYPE" => 'application/json'}

    patch api_v1_item_path(item_list.first[:id]), headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end