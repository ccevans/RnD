Rails.application.routes.draw do

  devise_for :users

  resources :lyrics do
  	member do
  		get "like", to: "lyrics#upvote"
  		get "dislike", to: "lyrics#downvote"
  	end

  	resources :comments
  end

  resources :arts
  


  root 'arts#index'
  
end
