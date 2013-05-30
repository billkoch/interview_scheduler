class CreateIntervieweePositionTable < ActiveRecord::Migration
  def change
    create_table :interviewees_positions, :id => false do |t|
      t.integer :interviewee_id
      t.integer :position_id
    end
  end
end
