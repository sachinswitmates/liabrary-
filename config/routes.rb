Rails.application.routes.draw do 
  devise_for :users, :controllers => {:registrations => "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' } do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end

  
  resources :bookings
 

  root 'welcome#index'
  get '/libraries/:id' => 'welcome#show', as: :library_detail

  namespace :admin do
    resources  :libraries
  end
  
  namespace :library_owner do
  	resources :libraries
    resources :bank_accounts
  end

  namespace :student do
    resources :libraries
  end


end
