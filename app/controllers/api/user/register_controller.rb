class Api::User::RegisterController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  respond_to :json
end
