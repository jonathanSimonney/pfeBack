class Position < ApplicationRecord
  acts_as_mappable :default_units => :kms
  belongs_to :user
end
