class ChangeSessionIdToBeStringInSessions < ActiveRecord::Migration[5.1]
  def change
    change_column :sessions, :session_id, :string
  end
end
