ActiveAdmin.register Article do
  permit_params :title, :content, :user_id

  form(html: { multipart: true }) do |f|
    f.inputs "article" do
      f.input :title
      f.input :content, as: :html_editor
      f.input :user
    end
    f.actions
  end

  index do
    id_column
    column :title
    column :content
    column :user
    actions
  end

end
