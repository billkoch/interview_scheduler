class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name, null: false, limit: 50

      t.timestamps
    end
  end
end
