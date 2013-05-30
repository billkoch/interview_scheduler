class AddAClassToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :a_class, :string
  end
end
