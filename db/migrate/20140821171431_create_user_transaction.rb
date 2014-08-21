class CreateUserTransaction < ActiveRecord::Migration
  def change
    create_table :user_transactions do |t|
      t.integer :user_id
      t.integer :transaction_id
    end
  end
end
