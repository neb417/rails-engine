class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def self.find_by_name(name_param)
    merchant = where('lower(name) ILIKE ?', "%#{name_param.downcase}%").order(:name).first

    # if merchant.nil?
    #   # binding.pry
    #   merchant.class
    # else
    #   merchant
    # end
  end
end