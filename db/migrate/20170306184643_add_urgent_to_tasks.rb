class AddUrgentToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :urgent, :string
  end
end
