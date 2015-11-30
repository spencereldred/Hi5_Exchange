class CreateTransactions < ActiveRecord::Migration
  def change
    create_table  :transactions do |t|
      t.integer   :group_id
      t.integer   :recycler_user_id
      t.integer   :redeemer_user_id
      t.datetime  :selection_date
      t.datetime  :completion_date
      t.integer   :rating
      t.float     :longitude
      t.float     :latitude
      t.string    :address
      t.string    :city
      t.string    :state
      t.string    :zipcode
      t.boolean   :selected,          default: false
      t.boolean   :completed,         default: false
      t.integer   :plastic
      t.integer   :cans
      t.integer   :glass
      t.integer   :other
      t.boolean   :cardboard,         default: false
      t.boolean   :non_hi5_plastic,   default: false
      t.boolean   :non_hi5_cans,      default: false
      t.boolean   :non_hi5_glass,     default: false
      t.boolean   :magazines,         default: false
      t.boolean   :newspaper,         default: false
      t.boolean   :paper,             default: false
      t.string    :trans_type

      t.timestamps
    end
  end
end
