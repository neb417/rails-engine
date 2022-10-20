class Api::V1::ItemMerchantsController < ApplicationController

  def show
    item = Item.find(params[:item_id])
    merchant_id = item.merchant_id
    if Merchant.find(merchant_id)
      render json: MerchantSerializer.new(Merchant.find(merchant_id))
    else
      render json: { data: { error: 'Merchant not Found' } }, status: 404
    end
  end
end