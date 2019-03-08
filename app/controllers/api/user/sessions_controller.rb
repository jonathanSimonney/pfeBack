class Api::User::SessionsController < Devise::SessionsController
  protect_from_forgery prepend: true
  respond_to :json

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user
      render user.session_login(sign_in_params[:password])
    else
      render json: {errors: {:email => ['is invalid']}}, status: :unprocessable_entity
    end


  end
end