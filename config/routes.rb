
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :clients do
        resources :dogs
      end
      resources :caregivers
      resources :walkings do 
        member do
          put :start_walk
          put :finish_walk
        end
      end
    end
  end
end
