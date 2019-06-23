class AddArticleCommentsToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :article_comments, :article, foreign_key: true
    add_reference :article_comments, :user, foreign_key: true
  end
end
