class ArticleCategory < ApplicationRecord
  mount_uploader :icon, PlaceIconsUploader
  has_many :articles
end
