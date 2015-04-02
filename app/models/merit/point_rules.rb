# Be sure to restart your server when you modify this file.
#
# Points are a simple integer value which are given to "meritable" resources
# according to rules in +app/models/merit/point_rules.rb+. They are given on
# actions-triggered, either to the action user or to the method (or array of
# methods) defined in the +:to+ option.
#
# 'score' method may accept a block which evaluates to boolean
# (recieves the object as parameter)

module Merit
  class PointRules
    include Merit::PointRulesMethods

    def initialize
      score 50, :on => 'user/registrations#create', model_name: 'User', category: 'profile'

       
       # score 10, :on => 'user/registrations#update', model_name: 'User' do |user|
        # current_user.avatar.present?
       #end


 

       
      #
      # score 15, :on => 'reviews#create', :to => [:reviewer, :reviewed]
      #
      # score 20, :on => [
      #   'comments#create',
      #   'photos#create'
      # ]

      score 10, on: 'lyrics#create', to: :user, description: 'Plus 20 points', category: 'lyric'

      score (-10), on: 'lyrics#destroy', to: :user, category: 'lyric'

      score 100, on: 'arts#create', to: :user, description: 'Plus 100 points', category: 'design'

      score (-100), on: 'arts#destroy', to: :user, category: 'design'

      score 10, on: 'posts#update', to: :user, category: 'blog' do |post|
        post.approve == true
      end

    


    end
  end
end
