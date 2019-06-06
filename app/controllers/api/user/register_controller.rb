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

  # make a creat_profile method that works as create BUT : - needs connection
  # - creates a profile instead of a user.
  def create_profile
    @user = User.where(authentication_token: params[:token]).first
    if @user
      body = JSON.parse request.raw_post
      # puts body
      unless body.key?("user")
        render :json => {:error => "wrong token"}, :status => :bad_request
      end

      user_profile = Profile.find_or_initialize_by(:user_id => @user.id)
      if body["user"]["profile_name"] != nil
        user_profile.update(:profile_name => body["user"]["profile_name"])
      end
      if body["user"]["profile_desc"] != nil
        user_profile.update(:profile_desc => body["user"]["profile_desc"])
      end
      if body["user"]["profile_pic"] != nil
        # raw_profile_pic = Base64.decode64 body["user"]["profile_pic"]
        # params[:filetype]
        user_profile.update(:profile_pic => body["user"]["profile_pic"])
      end
      render :json => {:result => "success"}
    else
      render :json => {:error => "wrong token"}, :status => :unauthorized
    end
  end
end
