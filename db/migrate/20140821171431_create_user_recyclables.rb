class CreateUserRecyclables < ActiveRecord::Migration
  def change
    create_table :user_recyclables do |t|
      t.references :user
      t.references :recyclable
      t.integer    :redeemer_id

      t.timestamps
    end
  end
end
