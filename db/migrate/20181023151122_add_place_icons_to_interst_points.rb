# frozen_string_literal: true

class AddPlaceIconsToInterstPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :interest_points, :icon, :string
  end
end
