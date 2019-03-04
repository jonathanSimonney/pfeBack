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
      end
      # post '/create', to: 'register#create'
    end
    namespace :map do
      namespace :interest_points do
        get '/:lat/:lng', action: :find_by, controller: 'interest_point'
        get '/icons', action: :list, controller: 'interest_point_category'
      end
    end
  end

end
