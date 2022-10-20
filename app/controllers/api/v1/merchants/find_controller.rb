class Api::V1::Merchants::FindController < ApplicationController
  def find
    merchant = Merchant.find_by_name(params[:name]).first
    if merchant.nil?
      render json: { data: { error: 'Merchant not found' } }
    else
      render json: MerchantSerializer.new(merchant)
    end
  end

  def find_all
    merchants = Merchant.find_by_name(params[:name])
    render json: MerchantSerializer.new(merchants)
  end
end
