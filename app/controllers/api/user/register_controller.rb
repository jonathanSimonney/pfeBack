class Api::User::RegisterController < Devise::RegistrationsController
  respond_to :json
end
