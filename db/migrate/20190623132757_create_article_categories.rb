class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.string :title
      t.string :icon

      t.timestamps
    end
  end
end
