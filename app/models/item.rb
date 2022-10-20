class Item < ApplicationRecord
  belongs_to :merchant

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  def self.find_by_name(query_params)
    where('lower(name) ILIKE ?', "%#{query_params.downcase}%").order(:name)
  end

  def self.find_by_min_price(query_params)
    query_params = query_params.to_f

    if query_params.negative?
      { error: 'Invalid price entry' }
    else
      where('unit_price >= ?', query_params).order(:name)
    end
  end

  def self.find_by_max_price(query_params)
    query_params = query_params.to_f

    if query_params.negative?
      { error: 'Invalid price entry' }
    else
      where('unit_price <= ?', query_params).order(:name)
    end
  end

  def self.find_by_price_range(query_params1, query_params2)
    query_params1 = query_params1.to_f
    query_params2 = query_params2.to_f

    if query_params1 > query_params2
      { error: 'Invalid price entry' }
    else
      where('unit_price BETWEEN ? AND ?', query_params1, query_params2).order(:name)
    end
  end
end