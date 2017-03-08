class AddImportantToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :important, :string
  end
end
