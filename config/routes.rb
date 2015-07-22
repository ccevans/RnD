Rails.application.routes.draw do

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  get 'pages/lyriclab'
  get 'pages/launch'
  get 'pages/how_it_works'
  get 'pages/about_us'
  get 'pages/handbook'
  get 'pages/faqs'
  get 'pages/partnerships'
  get 'pages/legal_terms'
  get 'pages/careers'
  get 'pages/events'
  get 'pages/testpage'
  get 'pages/testpage2'

  get 'tagged' => 'posts#tagged', :as => 'tagged'

  get 'dash' => 'profiles#dash', :as => 'dash'

  devise_for :users, :controllers => { :registrations => 'user/registrations', :invitations => 'user/invitation', omniauth_callbacks: 'user/omniauth_callbacks'}



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


    get 'filter' => 'arts#tagged', :as => 'filter'
    get 'tagged' => 'lyrics#tagged', :as => 'tagged'

    
  end

resources :lyrics, only: [] do
      member do
        get "like", to: "lyrics#upvote"
        get "dislike", to: "lyrics#downvote"
      end

      resources :comments
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
    resources :commentarts
  end

  resources :profiles do

    member do
      get :follow
      get :unfollow
    end
  
  end

  resources :products

  resources :homeinfo

  resources :videos
  resources :photos



  root 'pages#home"
  
  
end
