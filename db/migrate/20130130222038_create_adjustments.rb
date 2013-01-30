class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.references :item
      t.integer :delta
      t.boolean :reset

      t.timestamps
    end
    add_index :adjustments, :item_id
  end
end
