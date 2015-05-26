class DeleteUserFromTopic < ActiveRecord::Migration
  def up
    remove_column :topics, :user_id, :integer
  end

  def down
    add_column :topics, :user_id, :integer
    add_index :topics, :user_id
  end
end
