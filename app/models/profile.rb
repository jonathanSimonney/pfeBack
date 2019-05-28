class Profile < ApplicationRecord
  mount_uploader :profile_pic, PlaceIconsUploader
end
