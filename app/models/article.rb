class Article < ApplicationRecord
  belongs_to :user
  belongs_to :article_category

  has_many :article_upvotes, dependent: :destroy
  has_many :article_comments, dependent: :destroy

  def nb_upvote
    ArticleUpvote.where(article_id: self.id).count
  end
end
