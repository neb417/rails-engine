Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find', to: 'find#find'
        get '/find_all', to: 'find#find_all'
      end

      namespace :items do
        get '/find', to: 'find#find'
        get '/find_all', to: 'find#find_all'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: :index, controller: 'merchant_items'
        # get '/find', on: :collection, to: 'find#find', module: :merchants
      end

      resources :items do
        get '/merchant', to: 'item_merchants#show'
        # get '/find_all', on: :collection, to: 'find#find_all'
      end
    end
  end
end
