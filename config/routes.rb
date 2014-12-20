Rails.application.routes.draw do

  devise_for :users
  resources :lyrics do
  	resources :comments
  end
  


  root 'lyrics#index'
  
end
