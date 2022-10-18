require 'rails_helper'

RSpec.describe "Merchants API" do
  let!(:merchant_list) {create_list(:merchant, 10)}
  let!(:item_list) {create_list(:item, 50)}

  before(:each) do
    get api_v1_merchant_items_path(merchant_list.first)
  end

  it 'returns successful response' do
    expect(response).to be_successful
  end
end