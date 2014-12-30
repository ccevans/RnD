Rails.application.routes.draw do


  get 'pages/lyriclab'

  devise_for :users, :controllers => { :invitations => 'user/invitation'}

  resources :campaigns

  resources :profiles do

    member do
      get :follow
      get :unfollow
    end
  
  end

  get 'tagged' => 'lyrics#tagged', :as => 'tagged'


  resources :adminlyrics do
    member do
      get "like", to: "adminlyrics#upvote"
      get "dislike", to: "adminlyrics#downvote"
    end

    resources :commentlyrics
    
  end

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


  root 'campaigns#index'

  
  
end
