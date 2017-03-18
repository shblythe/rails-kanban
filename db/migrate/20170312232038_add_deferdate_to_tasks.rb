class AddDeferdateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :deferred_until, :date
  end
end
