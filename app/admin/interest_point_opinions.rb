ActiveAdmin.register InterestPointOpinion do
  permit_params :title, :message, :grade, :user_id, :interest_point_id

  form(html: { multipart: true }) do |f|
    f.inputs "notation d'un point d'intérêt" do
      f.input :title
      f.input :message
      f.input :grade
      f.input :user
      f.input :interest_point
    end
    f.actions
  end

  index do
    id_column
    column :title
    column :message
    column :grade
    column :user
    column :interest_point
    actions
  end
end
