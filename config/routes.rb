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
          get 'most_revenue'
          get 'most_items'
        end
      end

      resources :merchants, only: [:index, :show] do
        member do
          get "items"
          get "invoices"
          get "revenue"
          get "favorite_customer"
          get "customers_with_pending_invoices"
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

      resources :invoice_items, only: [:show] do
        member do
          get "item"
          get "invoice"
        end
      end

      resources :items, only: [:show] do
        member do
          get "invoice_items"
          get "merchant"
          get "most_revenue"
        end
      end

      resources :transactions, only: [:show] do
        member do
          get "invoice"
        end
      end

      resources :customers, only: [:show] do
        member do
          get "invoices"
          get "transactions"
          get "favorite_merchant"
        end
      end

    end
  end
end
