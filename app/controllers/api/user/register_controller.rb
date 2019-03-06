class Api::User::RegisterController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  respond_to :json
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
      end
      render :json => resource
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :json => resource.errors.full_messages, :status => :forbidden
    end
  end
end
