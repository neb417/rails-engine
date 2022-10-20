class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.where(id: params[:id]).empty?
      render json: { data: { error: 'Merchant not Found' } }, status: 404
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end
  end
end
