ActiveAdmin.register InterestPoint do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :lat, :lng, :icon, :description
#
# or
#
  form(:html => { :multipart => true }) do |f|
    f.inputs "point d'intérêt" do
      f.input :title
      f.input :lat
      f.input :lng
      f.input :icon, :as => :file
      f.input :description, as: :html_editor
    end
    f.actions
  end

  index do
    id_column
    column :title
    column :lat
    column :lng
    column "Icon" do |interestPoint|
      image_tag(interestPoint.icon.url, width: 300)
    end
    column :description
    actions
  end

end
