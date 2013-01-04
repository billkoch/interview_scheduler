class InterviewBelongsToPosition < ActiveRecord::Migration
  def up
    change_table :interviews do |t|
      t.references :position
    end
    remove_column :interviews, :position
  end

  def down
    remove_column :interviews, :position_id
    add_column :interviews, :position, :string, limit: 50
  end
end
