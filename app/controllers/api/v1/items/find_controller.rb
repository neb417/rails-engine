class Api::V1::Items::FindController < ApplicationController

  def find_all
    if params[:name]
      items = Item.find_all_by_name(params[:name])
      if items.nil?
        render json: { data: { error: 'Items not found' } }
      else
        render json: ItemSerializer.new(items)
      end
    elsif params[:min_price]
      items = Item.find_all_by_min_price(params[:min_price])
      if items.nil?
        render json: { data: { error: 'Items not found' } }
      else
        render json: ItemSerializer.new(items)
      end
    elsif params[:max_price]
      items = Item.find_all_by_max_price(params[:max_price])
      if items.nil?
        render json: { data: { error: 'Items not found' } }
      else
        render json: ItemSerializer.new(items)
      end
    end
  end
end