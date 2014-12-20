Rails.application.routes.draw do

  devise_for :users
  resources :lyrics

  root 'lyrics#index'
  
end
