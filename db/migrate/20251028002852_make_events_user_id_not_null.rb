class MakeEventsUserIdNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :events, :user_id, false
  end
end
