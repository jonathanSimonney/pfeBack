Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', action: :index, controller: 'welcome'

  namespace :api do
    get '/interestPoints/:lat/:lng', action: :find_by, controller: 'interest_point'
  end

end
