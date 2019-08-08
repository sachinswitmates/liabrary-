Rails.application.routes.draw do 
  devise_for :users, :controllers => {:registrations => "users/registrations"} do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'welcome#index'


  namespace :admin do
    resources  :libraries
  end
  namespace :library_owner do
  	resources :libraries
  end

end
