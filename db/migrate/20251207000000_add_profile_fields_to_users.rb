class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :description, :text
    add_column :users, :graduation_year, :integer
    add_column :users, :major, :string
  end
end
