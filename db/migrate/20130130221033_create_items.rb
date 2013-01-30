class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :aliases
      t.float :weight

      t.timestamps
    end
  end
end
