class InterestPoint < ApplicationRecord
  mount_uploader :icon, PlaceIconsUploader
  acts_as_mappable :default_units => :kms
end
