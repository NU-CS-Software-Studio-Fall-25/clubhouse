class AddDescriptionAndUsersAttendingToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :description, :text, default: "", null: false
    # store users_attending as a JSON array in a text column for sqlite compatibility
    add_column :events, :users_attending, :text, default: "[]", null: false
  end
end
