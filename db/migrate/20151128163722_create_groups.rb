class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|

      t.string    :name
      t.integer   :member_count
      t.string    :promo_code
      t.string    :url
      t.text      :description

      t.timestamps
    end
  end
end
