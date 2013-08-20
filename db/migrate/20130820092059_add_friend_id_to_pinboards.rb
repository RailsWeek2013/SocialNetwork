class AddFriendIdToPinboards < ActiveRecord::Migration
  def change
    add_column :pinboards, :friend_id, :integer
  end
end
