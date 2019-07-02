Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :clients do
        resources :dogs
      end
      resources :caregivers
      resources :walkings
    end
  end
end
