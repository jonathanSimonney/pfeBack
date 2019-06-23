class AddForeignLinkingToArticleUpvote < ActiveRecord::Migration[5.2]
  def change
    add_reference :article_upvotes, :user, foreign_key: true
    add_reference :article_upvotes, :article, foreign_key: true
  end
end
