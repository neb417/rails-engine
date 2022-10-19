require 'rails_helper'

RSpec.describe 'Item Merchant' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

  it 'has successful response' do
    get api_v1_item_merchant_path(item_list.first.id)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'returns API in JSON format' do
    get api_v1_item_merchant_path(item_list.first.id, item_list.first.merchant_id)
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:id]).to be_a(String)
    expect(merchant[:attributes][:name]).to be_an(String)
  end

  xit 'returns 404 when not found' do
    get api_v1_item_merchant_path(item_list.last.id + 1)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end