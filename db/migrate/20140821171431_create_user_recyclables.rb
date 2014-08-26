class CreateUserRecyclables < ActiveRecord::Migration
  def change
    create_table :user_recyclables do |t|
      t.references :user
      t.references :recyclable

      t.timestamps
    end
  end
end
