class AddColumnsToRecyclables < ActiveRecord::Migration
  def change
    add_column :recyclables, :address, :string
    add_column :recyclables, :city, :string
    add_column :recyclables, :state, :string
    add_column :recyclables, :zipcode, :string
    add_column :recyclables, :selected_redeemer_id, :integer
  end
end
