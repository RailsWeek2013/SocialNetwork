class AddStatusToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :Status, :boolean
  end
end
