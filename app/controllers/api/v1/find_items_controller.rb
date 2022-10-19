class Api::V1::FindItemsController < ApplicationController

  def find_all
    items = Item.find_all_by_name(params[:name])

    if items.nil?
      render json: { data: { error: 'Merchant not found' } }
    else
      render json: ItemSerializer.new(items)
    end
  end
end