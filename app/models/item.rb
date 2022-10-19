class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.find_all_by_name(query_params)
    where('lower(name) ILIKE ?', "%#{query_params.downcase}%")
  end
end