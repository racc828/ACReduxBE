class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :name
      t.integer :project_id
      t.integer :positionX
      t.integer :positionY

      t.timestamps
    end
  end
end
