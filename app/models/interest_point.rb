# frozen_string_literal: true

class InterestPoint < ApplicationRecord
  mount_uploader :icon, PlaceIconsUploader
  acts_as_mappable default_units: :kms
  belongs_to :interest_point_category
  has_many :interest_point_opinions
end
