class AddStateToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :state, :string, default: 'open'
  end
end
