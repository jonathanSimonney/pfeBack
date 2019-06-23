# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', action: :index, controller: 'welcome'

  namespace :api do
    namespace :user do
      devise_scope :user do
        post '/create', to: 'register#create'
        post '/login', to: 'sessions#create'
        post '/profile/:token', to: 'register#create_profile'
        get '/profile/:user_id', to: 'sessions#public_show'
      end
    end
    namespace :map do
      namespace :position do
        post '/add/:lat/:lng/:token', action: :add, controller: 'position'
      end
      namespace :interest_points do
        post '/opinion/create/:token/:interest_point_id', action: :create_opinion, controller: 'interest_point'
        get '/:lat/:lng', action: :find_by, controller: 'interest_point'
        get '/icons', action: :list, controller: 'interest_point_category'
      end
    end
    namespace :blog do
      namespace :article do
        post '/create/:token', action: :add_article, controller: 'article'
        post '/upvote/:token/:article_id', action: :upvote_article, controller: 'article'
        get '/category/list', action: :list_category, controller: 'article'
        get '/category/:category_id', action: :list_article_in_category, controller: 'article'
        get '/', action: :list_article, controller: 'article'
      end
      # namespace :comment do
      #   post 'create/:token/:article_id', action: :create_comment, controller: 'comment'
      # end
    end
  end
end
