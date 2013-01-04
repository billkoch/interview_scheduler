class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.string :room, null: false, limit: 50
      t.string :position, null: false, limit: 50
      t.timestamp :scheduled_at, null: false

      t.timestamps
    end
  end
end
