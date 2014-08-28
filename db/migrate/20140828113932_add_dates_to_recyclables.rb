class AddDatesToRecyclables < ActiveRecord::Migration
  def change
    add_column :recyclables, :selected_date, :datetime
    add_column :recyclables, :completed_date, :datetime
  end
end
