class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :group_id
      t.string  :email
      t.string  :function
      t.string  :first_name
      t.string  :last_name
      t.string  :address
      t.string  :city
      t.string  :state
      t.string  :zipcode
      t.string  :phone
      t.float   :latitude
      t.float   :longitude
      t.integer :radius, default: 8

      t.references :user
      t.timestamps
    end
  end
end
