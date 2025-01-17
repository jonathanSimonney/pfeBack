ActiveAdmin.register ArticleCategory do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :icon
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form(html: { multipart: true }) do |f|
    f.inputs "catégorie d'article" do
      f.input :title
      f.input :icon, as: :file
    end
    f.actions
  end

  index do
    id_column
    column :title
    column 'Icon' do |category|
      image_tag(category.icon.url, width: 300)
    end
    actions
  end
end
