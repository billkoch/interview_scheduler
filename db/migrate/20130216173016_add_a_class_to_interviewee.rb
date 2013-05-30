class AddAClassToInterviewee < ActiveRecord::Migration
  def change
    add_column :interviewees, :a_class, :string
  end
end
