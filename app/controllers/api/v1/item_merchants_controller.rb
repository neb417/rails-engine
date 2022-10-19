class Api::V1::ItemMerchantsController < ApplicationController

  def show
    item = Item.find(params[:item_id])
    merchant_id = item.merchant_id
    if Merchant.find(merchant_id)
      render json: MerchantSerializer.new(Merchant.find(merchant_id))
    else
      render json: { error: 'Item not Found' }, status: :not_found
      render json: { error: 'Merchant not Found' }, status: :not_found
    end
  end
end