class Api::V1::Merchants::FindController < ApplicationController
  before_action :find_merchants, only: %i[find find_all]
  def find
    if @merchants.nil?
      render json: { data: { error: 'Merchant not found' } }
    else
      merchant = @merchants.first
      renderer(merchant)
    end
  end

  def find_all
    renderer(@merchants)
  end

  private

  def find_merchants
    @merchants = Merchant.find_by_name(params[:name])
  end

  def renderer(merchants)
    render json: MerchantSerializer.new(merchants)
  end
end