Rails.application.routes.draw do 
  
  root 'welcome#index'
  devise_for :users, :controllers => {:registrations => "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' } do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get '/libraries/:id' => 'welcome#show', as: :library_detail
  namespace :admin do
    resources  :libraries
  end
  namespace :library_owner do
  	resources :libraries do
      member do
        get 'library_bookings'
      end
    end
    resources :bank_accounts
  end
  namespace :student do
    resources :libraries
  end
  
  resources :bookings, only: [:index, :show]
  get    '/libraries/:library_id/bookings',  to: 'bookings#new', as: 'new_library_booking'
  post   '/libraries/:library_id/bookings',  to: 'bookings#create', as: 'create_library_booking'
end
