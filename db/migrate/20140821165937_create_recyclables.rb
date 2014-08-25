class CreateRecyclables < ActiveRecord::Migration
  def change
    create_table :recyclables do |t|
      t.string :trans_type
      t.integer :plastic
      t.integer :cans
      t.integer :glass
      t.integer :other
      t.boolean :non_hi5_plastic,   default: false
      t.boolean :non_hi5_cans,      default: false
      t.boolean :non_hi5_glass,     default: false
      t.boolean :cardboard,         default: false
      t.boolean :magazines,         default: false
      t.boolean :newspaper,         default: false
      t.boolean :paper,             default: false
      t.boolean :selected,          default: false
      t.boolean :completed,         default: false
      t.integer :rating

      t.timestamps
    end
  end
end
