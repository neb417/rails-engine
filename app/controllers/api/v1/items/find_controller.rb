class Api::V1::Items::FindController < ApplicationController
  def find_all
    # returns item collection
    passed_params_logic
  end

  def find
    # returns single item
    passed_params_logic
  end

  private

  def passed_params_logic
    if params[:name] && (params[:min_price] || params[:max_price])
      name_price_error
    elsif params[:min_price] && params[:max_price]
      find_range
    elsif params[:name]
      find_name
    elsif params[:min_price]
      find_min_price
    elsif params[:max_price]
      find_max_price
    end
  end

  def find_name
    items = Item.find_by_name(params[:name])
    render_items_logic(find_all_or_find_one(items))
  end

  def find_min_price
    items = Item.find_by_min_price(params[:min_price])
    negative_input_evaluation(find_all_or_find_one(items))
  end

  def find_max_price
    items = Item.find_by_max_price(params[:max_price])
    negative_input_evaluation(find_all_or_find_one(items))
  end

  def find_range
    items = Item.find_by_price_range(params[:min_price], params[:max_price])
    negative_input_evaluation(find_all_or_find_one(items))
  end

  def render_items_logic(items)
    if items.nil?
      render json: { data: { error: 'Items not found' } }, status: 400
    else
      render json: ItemSerializer.new(items)
    end
  end

  def name_price_error
    render json: { data: { error: 'Name and price cannot be searched' } }, status: 400
  end

  def negative_input_evaluation(items)
    if items == { error: 'Invalid price entry' }
      render json: items, status: 400
    else
      render_items_logic(items)
    end
  end

  def find_all_or_find_one(items)
    if params[:action] == 'find_all'
      items
    else
      passed_in_error_or_not(items)
    end
  end

  def passed_in_error_or_not(items)
    if items.first.instance_of?(Array)
      items
    else
      items.first
    end
  end
end
