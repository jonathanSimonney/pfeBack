# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :user, foreign_key: true
      t.string :profile_pic
      t.string :profile_name
      t.text :profile_desc
      t.timestamps
    end
  end
end
