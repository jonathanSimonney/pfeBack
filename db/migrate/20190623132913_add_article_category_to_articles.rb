class AddArticleCategoryToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :article_category, foreign_key: true
  end
end
