# frozen_string_literal: true

class CreateInterestPointCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :interest_point_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
