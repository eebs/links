class AddUserIdToLink < ActiveRecord::Migration
  def change
    add_column :links, :user_id, :integer

    add_index :links, [:user_id, :created_at]
  end
end
