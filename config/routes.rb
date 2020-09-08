Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#guestfeed"
  get 'newest', to: 'home#newest'
  get 'feed', to: 'home#feed'
  get 'discover', to: 'home#discover'
  resources :users ,except: [:index, :destroy] do
    member do
      get 'profile', to: 'home#profile'
   end
   resource :photos
   resource :albums
  end
  resources :photos ,except: ['show']
  resources :albums ,except: ['show']
  namespace :admin do
    resources :users, shallow: true
  end
end
