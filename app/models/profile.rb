class Profile < ApplicationRecord
  mount_uploader :profile_pic, PlaceIconsUploader
  mount_base64_uploader :profile_pic, PlaceIconsUploader

end
