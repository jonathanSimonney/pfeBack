# frozen_string_literal: true

ActiveAdmin.register Position do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :user_id, :shared_at, :lat, :lng

  form(html: { multipart: true }) do |f|
    f.inputs 'position partagée' do
      f.input :user
      f.input :lat
      f.input :lng
      f.input :shared_at
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
