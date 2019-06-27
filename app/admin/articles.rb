ActiveAdmin.register Article do
  permit_params :title, :content, :user_id, :article_category_id

  form(html: { multipart: true }) do |f|
    f.inputs "article" do
      f.input :title
      f.input :content
      f.input :user
      f.input :article_category
    end
    f.actions
  end

  index do
    id_column
    column :title
    column :content
    column :user
    column 'Category' do |article|
      if article.article_category
        image_tag(article.article_category.icon.url, width: 300)
      else
        'Category not selected'
      end
    end
    actions
  end

end
