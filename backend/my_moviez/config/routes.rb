Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get :echo, to: 'movies#echo'
      resources :movies, only: [:index, :show]
      resources :actors, only: [:index, :show]
      resources :users, only: [:index, :show]
      get :profile, to: 'profiles#show'

    end
  end
  scope :api, defaults: { format: 'json' } do
    resources :sessions, only: [:create]
    resources :registrations, only: [:create]
    # Counties and cities
    resources :countries, only: [:index], param: :code do
      resources :states, only: [], param: :code do
        resources :cities, only: :index
      end
    end
  end
end
