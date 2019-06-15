class AddVehicleSectionToProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :vehicle_desc, :text
    add_column :profiles, :vehicle_pic, :string
  end
end
