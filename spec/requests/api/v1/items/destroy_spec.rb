require 'rails_helper'

RSpec.describe 'Destroy and Item' do
  let!(:item_list) { create_list(:item, 10) }

  describe 'destroy tests' do
    it 'returns successful response' do
      delete api_v1_item_path(item_list.first.id)

      items = Item.all.count

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(item_list.count - 1).to eq(items)
    end
  end
end