class AddDescriptionToBookmark < ActiveRecord::Migration
  def change
    add_column :bookmarks, :description, :string
    add_index :bookmarks, :description
  end
end
