ActiveAdmin.register InterestPoint do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :lat, :lng, :icon, :description, :interest_point_category_id
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
      f.input :interest_point_category
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
    column "Category" do |interestPoint|
      if interestPoint.interest_point_category
        image_tag(interestPoint.interest_point_category.icon.url, width: 300)
      else
        "Category not selected"
      end
    end
    column :description
    actions
  end

end
