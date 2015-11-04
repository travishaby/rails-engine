Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers,
                :merchants,
                :items,
                :invoices,
                :invoice_items,
                :transactions,
      only: [:index, :show] do
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end

      resources :merchants, only: [:show] do
        member do
          get "items"
          get "invoices"
        end
      end

      resources :invoices, only: [:show] do
        member do
          get "items"
          get "invoice_items"
          get "transactions"
          get "customer"
          get "merchant"
        end
      end

    end
  end
end
