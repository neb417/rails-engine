require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to :merchant }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description}
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    let!(:item_list) { create_list(:item, 15) }

    it '#find_by_name' do
      items = Item.find_by_name('in')

      expect(items.count).to be < Item.all.count

      items.each do |item|
        expect(item.id).to be_an(Integer)
        expect(item.name).to be_a(String)
        expect(item.unit_price).to be_a(Float)
        expect(item.merchant_id).to be_an(Integer)
      end
    end

    it '#find_by_min_price' do
      items = Item.find_by_min_price(140.0)

      expect(items.count).to be < Item.all.count

      items.each do |item|
        expect(item.id).to be_an(Integer)
        expect(item.name).to be_a(String)
        expect(item.unit_price).to be_a(Float)
        expect(item.merchant_id).to be_an(Integer)
      end

      items = Item.find_by_min_price(-1)

      expect(items).to eq({ error: 'Invalid price entry' })
    end

    it '#find_by_max_price' do
      items = Item.find_by_max_price(140.0)

      expect(items.count).to be < Item.all.count

      items.each do |item|
        expect(item.id).to be_an(Integer)
        expect(item.name).to be_a(String)
        expect(item.unit_price).to be_a(Float)
        expect(item.merchant_id).to be_an(Integer)
      end

      items = Item.find_by_max_price(-1)

      expect(items).to eq({ error: 'Invalid price entry' })
    end

    it '#find_by_price_range' do
      items = Item.find_by_price_range(140.0, 240.0)

      expect(items.count).to be < Item.all.count

      items.each do |item|
        expect(item.id).to be_an(Integer)
        expect(item.name).to be_a(String)
        expect(item.unit_price).to be_a(Float)
        expect(item.merchant_id).to be_an(Integer)
      end

      items = Item.find_by_price_range(50, 25)

      expect(items).to eq({ error: 'Invalid price entry' })
    end
  end
end