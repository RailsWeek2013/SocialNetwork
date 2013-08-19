class ChangeColumnNameStatusFromFriendship < ActiveRecord::Migration
	def change
		change_table :friendships do |t|
			
			t.rename :Status, :status
		end
	end
end
