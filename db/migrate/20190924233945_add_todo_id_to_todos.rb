class AddTodoIdToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :todo_id, :integer
  end
end
