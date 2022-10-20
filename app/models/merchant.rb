class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def self.find_by_name(name_param)
    where('lower(name) ILIKE ?', "%#{name_param.downcase}%").order(:name)
  end
end