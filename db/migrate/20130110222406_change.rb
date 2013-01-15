class Change < ActiveRecord::Migration
  def up
    rename_column :positions, :name, :title
  end

  def down
    rename_column :positions, :title, :name
  end
end
