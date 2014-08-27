class AddUserIdToRecyclables < ActiveRecord::Migration
  def change
    add_column :recyclables, :user_id, :integer
  end
end
