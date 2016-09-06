Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    post 'authenticate', to: 'authentication#authenticate'
    namespace :v1 do
      resources :movies, only: [:index, :show]
      resources :actors, only: [:index, :show]
      resources :users, only: [:index, :show]
    end
  end
end
