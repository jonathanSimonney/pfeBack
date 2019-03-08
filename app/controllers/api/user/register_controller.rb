class Api::User::RegisterController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  respond_to :json
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      render :json => resource
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :json => resource.errors.full_messages, :status => :forbidden
    end
  end
end
