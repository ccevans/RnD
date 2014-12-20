Rails.application.routes.draw do

  resources :lyrics

  root 'lyrics#index'
  
end
