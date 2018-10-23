class CreateInterestPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :interest_points do |t|
      t.string :title
      t.decimal :lat, {:precision=>10, :scale=>6}
      t.decimal :lng, {:precision=>10, :scale=>6}

      t.timestamps
    end
  end
end
