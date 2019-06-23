# frozen_string_literal: true

class Api::User::RegisterController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  respond_to :json
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      render json: resource
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: resource.errors.full_messages, status: :forbidden
    end
  end

  def create_profile
    @user = User.where(authentication_token: params[:token]).first
    if @user
      body = JSON.parse request.raw_post
      # puts body
      unless body.key?('user')
        render json: { error: 'no key user in json' }, status: :bad_request
      end

      user_profile = Profile.find_or_initialize_by(user_id: @user.id)
      unless body['user']['profile_name'].nil?
        user_profile.update(profile_name: body['user']['profile_name'])
      end
      unless body['user']['profile_desc'].nil?
        user_profile.update(profile_desc: body['user']['profile_desc'])
      end
      unless body['user']['profile_pic'].nil?
        # raw_profile_pic = Base64.decode64 body["user"]["profile_pic"]
        # params[:filetype]
        #
        image_as_file = parse_image_data(body['user']['profile_pic'])
        user_profile.update(profile_pic: image_as_file)
      end

      unless body['user']['vehicle_desc'].nil?
        user_profile.update(vehicle_desc: body['user']['vehicle_desc'])
      end
      unless body['user']['vehicle_pic'].nil?
        # raw_profile_pic = Base64.decode64 body["user"]["profile_pic"]
        # params[:filetype]
        #
        image_as_file = parse_image_data(body['user']['vehicle_pic'])
        user_profile.update(vehicle_pic: image_as_file)
      end
      render json: { result: 'success' }
    else
      render json: { error: 'wrong token' }, status: :unauthorized
    end
  ensure
    clean_tempfile
  end

  private

  def parse_image_data(base64_image)

    # puts base64_image
    filename = 'upload-image'

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(base64_image)
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(';')[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new(
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    )
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
end
