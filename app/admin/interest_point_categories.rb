ActiveAdmin.register InterestPointCategory do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :icon
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  form(:html => { :multipart => true }) do |f|
    f.inputs "catégorie de point d'intérêt" do
      f.input :name
      f.input :icon, :as => :file
    end
    f.actions
  end

  index do
    id_column
    column :name
    column "Icon" do |interestPoint|
      image_tag(interestPoint.icon.url, width: 300)
    end
    actions
  end
end
