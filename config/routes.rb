Rails.application.routes.draw do
  # Authentication routes
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  namespace :admin do
    get 'dashboard', to: 'dashboard#index', as: :dashboard
    resources :categories
    resources :suppliers
    resources :products
    resources :stock_movements, only: [:index, :show, :create] do
      collection do
        get :new_in
        get :new_out
      end
    end
    get 'reports/inventory', to: 'reports#inventory', as: :inventory_report
  end

  root "admin/dashboard#index"
end