class CreateInterviewees < ActiveRecord::Migration
  def change
    create_table :interviewees do |t|
      t.string :last_name, null: false, limit: 50
      t.string :first_name, null: false, limit: 50
      t.string :email, null: false, limit: 50

      t.timestamps
    end
  end
end
