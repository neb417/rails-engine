class Api::V1::ItemMerchantsController < ApplicationController
  def show
    if Item.where(id: params[:item_id]).empty?
      render json: { data: { error: 'Merchant not Found' } }, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find(find_merchant))
    end
  end

  private

  def find_merchant
    item = Item.find(params[:item_id])
    item.merchant_id
  end
end
