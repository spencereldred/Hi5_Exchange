class AddLongitudeAndLatitudeToRecyclables < ActiveRecord::Migration
  def change
    add_column :recyclables, :longitude, :float
    add_column :recyclables, :latitude, :float
  end
end
