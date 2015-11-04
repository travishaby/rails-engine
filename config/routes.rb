Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers,
                :merchants,
                :items,
                :invoices,
                :invoice_items,
      only: [:index, :show] do
        collection do
          get 'find'
          get 'find_all'
          get 'random'
        end
      end


    end
  end
end
