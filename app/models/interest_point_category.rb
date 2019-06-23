# frozen_string_literal: true

class InterestPointCategory < ApplicationRecord
  mount_uploader :icon, PlaceIconsUploader
  has_many :interest_points, dependent: :destroy
end
