# frozen_string_literal: true

class AddInterestPointCategoryToInterestPoints < ActiveRecord::Migration[5.2]
  def change
    add_reference :interest_points, :interest_point_category, foreign_key: true
  end
end
