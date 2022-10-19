require 'rails_helper'

RSpec.describe 'Item Merchant' do
  let!(:merchant_list) { create_list(:merchant, 10) }
  let!(:item_list) { create_list(:item, 50) }

  it 'has successful response' do
    get api_v1_item_merchant_path(item_list.first.id)

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end