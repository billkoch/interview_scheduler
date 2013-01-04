class AddRelationshipBetweenIntervieweeAndInterview < ActiveRecord::Migration
  def up
    change_table :interviews do |t|
      t.references :interviewee
    end
  end

  def down
    remove_column :interviews, :interviewee
  end
end
