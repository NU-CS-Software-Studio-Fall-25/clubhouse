class AddStatusToMemberships < ActiveRecord::Migration[8.0]
  def change
    add_column :memberships, :status, :string, default: "pending", null: false
    add_index :memberships, :status
  end
end
