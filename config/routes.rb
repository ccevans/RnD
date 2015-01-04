Rails.application.routes.draw do


  post '/rate' => 'rater#create', :as => 'rate'
  get 'pages/lyriclab'

  get 'tagged' => 'lyrics#tagged', :as => 'tagged'

  devise_for :users, :controllers => { :invitations => 'user/invitation'}

  resources :campaigns do
    resources :lyrics

      resources :arts 
  end

resources :lyrics, only: [] do
      member do
        get "like", to: "lyrics#upvote"
        get "dislike", to: "lyrics#downvote"
      end

      resources :comments, shallow: true
    end



  resources :arts, only: [] do
    resources :ratings
    resources :commentarts, shallow: true
  end

  resources :profiles do

    member do
      get :follow
      get :unfollow
    end
  
  end


  root 'campaigns#index'

  
  
end
