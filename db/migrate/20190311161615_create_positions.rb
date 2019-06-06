# frozen_string_literal: true

class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.references :user, foreign_key: true

      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.datetime :shared_at
      t.timestamps
    end
  end
end
