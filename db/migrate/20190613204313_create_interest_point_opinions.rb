class CreateInterestPointOpinions < ActiveRecord::Migration[5.2]
  def change
    create_table :interest_point_opinions do |t|
      t.string :title
      t.text :message
      t.integer :grade

      t.timestamps
    end
  end
end
