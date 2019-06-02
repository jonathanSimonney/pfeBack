ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :email, :password, :password_confirmation, :authentication_token, profile_attributes: [:id, :profile_name, :profile_desc, :profile_pic]

  index do
    selectable_column
    id_column
    column :email
    column "profilePicture" do |user|
      if user.profile && user.profile.profile_pic.file
        image_tag(user.profile.profile_pic.url, width: 300)
      else
        "no profile picture"
      end
    end
    column "profileName" do |user|
      if user.profile
        user.profile.profile_name
      else
        "no profile"
      end
    end

    column "profileDesc" do |user|
      if user.profile
        user.profile.profile_desc
      else
        "no profile"
      end
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :authentication_token
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :authentication_token
      f.inputs "Profile", for: [:profile, f.object.profile || Profile.new] do |profile_form|
        profile_form.input :profile_name
        profile_form.input :profile_desc, as: :html_editor
        profile_form.input :profile_pic, :as => :file
      end
    end
    f.actions
  end

  controller do
    def update
      model = :user

      if params[model][:password].blank?
        %w(password password_confirmation).each { |p| params[model].delete(p) }
      end

      super
    end
  end
end
