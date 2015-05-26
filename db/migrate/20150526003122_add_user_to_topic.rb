class AddUserToTopic < ActiveRecord::Migration
  def up
    add_column :topics, :user_id, :integer
    add_index :topics, :user_id
  end

  def down
    remove_column :topics, :user_id, :integer
  end
end
