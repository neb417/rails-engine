require 'rails_helper'

RSpec.describe 'Non-ReSTful find merchant API' do
  let!(:merchant_list) { create_list(:merchant, 10) }

  it 'response is succcessful' do
    find_params = { name: 'o' }

    get api_v1_merchants_find_path, params: find_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'returns 1 merchant with correct attributes' do
    find_params = {name: 'o'}

    get api_v1_merchants_find_path, params: find_params

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)
    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
  end

  it 'returns 1 merchant with correct attributes' do
    find_params = {name: 'XZ'}

    get api_v1_merchants_find_path, params: find_params

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end