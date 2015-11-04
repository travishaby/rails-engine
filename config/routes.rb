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

    end
  end
end
