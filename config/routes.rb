Rails.application.routes.draw do

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get 'pages/lyriclab'

  get 'tagged' => 'posts#tagged', :as => 'tagged'

  devise_for :users, :controllers => { :invitations => 'user/invitation', omniauth_callbacks: 'user/omniauth_callbacks'}

resources :posts do
  member do
    get "like", to: "posts#upvote"
    get "dislike", to: "posts#downvote"
  end
  
  resources :commentposts
end

  resources :campaigns do
      resources :lyrics 
      resources :arts


    get 'tagged' => 'arts#tagged', :as => 'filter'
    get 'tagged' => 'lyrics#tagged', :as => 'tagged'

    
  end

resources :lyrics, only: [] do
      member do
        get "like", to: "lyrics#upvote"
        get "dislike", to: "lyrics#downvote"
      end

      resources :comments, shallow: true
    end



  resources :arts, only: [] do
    member do
      put "voteof1", to: "arts#voteof1"
      put "voteof2", to: "arts#voteof2"
      put "voteof3", to: "arts#voteof3"
      put "voteof4", to: "arts#voteof4"
      put "voteof5", to: "arts#voteof5"
    end

    resources :ratings
    resources :commentarts, shallow: true
  end

  resources :profiles do

    member do
      get :follow
      get :unfollow
    end
  
  end

  resources :products


  root 'campaigns#index'

  
  
end
