class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.find_all_by_name(query_params)
    where('lower(name) ILIKE ?', "%#{query_params.downcase}%")
  end

  def self.find_all_by_min_price(query_params)
    query_params = query_params.to_f
    where('unit_price >= ?', query_params)
  end

  def self.find_all_by_max_price(query_params)
    query_params = query_params.to_f
    where('unit_price <= ?', query_params)
  end
end