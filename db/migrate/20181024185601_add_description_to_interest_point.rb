# frozen_string_literal: true

class AddDescriptionToInterestPoint < ActiveRecord::Migration[5.2]
  def change
    add_column :interest_points, :description, :text
  end
end
