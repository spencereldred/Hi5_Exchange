class AddRedeemableIdToUserRecyclables < ActiveRecord::Migration
  def change
    add_column :user_recyclables, :redeemer_id, :integer
  end
end