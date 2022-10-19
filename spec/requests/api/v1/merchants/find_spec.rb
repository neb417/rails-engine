require 'rails_helper'

RSpec.describe 'Non-ReSTful API' do
  let!(:merchant_list) { create_list(:merchant, 10) }

  before :each do
    get api_v1_merchant_find_path(merchant_list.first.id)
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
  end

  it 'response is succcessful' do
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'returns 1 merchant with correct attributes' do
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end
end