class Article < ApplicationRecord
  belongs_to :user
  belongs_to :article_category

  has_many :article_upvotes, dependent: :destroy

end
