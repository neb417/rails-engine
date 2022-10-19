require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    let!( :merchant_list ) { create_list(:merchant, 5) }

    it '#find_by_name' do
      expect(Merchant.find_by_name('e')).to be_a(Merchant)
    end
  end
end