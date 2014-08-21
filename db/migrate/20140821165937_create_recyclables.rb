class CreateRecyclables < ActiveRecord::Migration
  def change
    create_table :recyclables do |t|
      t.string :trans_type
      t.integer :plastic
      t.integer :cans
      t.integer :glass
      t.integer :other
      t.boolean :non_hi5_plastic
      t.boolean :non_hi5_cans
      t.boolean :non_hi5_glass
      t.boolean :cardboard
      t.boolean :magazines
      t.boolean :newspaper
      t.boolean :paper
      t.boolean :selected
      t.boolean :completed
      t.integer :rating

      t.timestamps
    end
  end
end
