Rails.application.routes.draw do

  get 'profiles/show'

  devise_for :users

  resources :lyrics do
  	member do
  		get "like", to: "lyrics#upvote"
  		get "dislike", to: "lyrics#downvote"
  	end

  	resources :comments
  end

  resources :arts do
    member do
      get "like", to: "arts#upvote"
      get "dislike", to: "arts#downvote"
    end

    resources :commentarts

  end

  resources :admin_lyrics
  


  root 'arts#index'

  get '/:id', to: 'profiles#show'
  
end
