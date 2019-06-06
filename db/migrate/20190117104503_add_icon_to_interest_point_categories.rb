# frozen_string_literal: true

class AddIconToInterestPointCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :interest_point_categories, :icon, :string
  end
end
