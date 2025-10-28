class MakeClubsUserIdNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :clubs, :user_id, false
  end
end
