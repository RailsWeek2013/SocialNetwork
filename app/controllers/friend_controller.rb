class FriendController < ApplicationController

	def friendhome
		@friends = current_user.accepted_friends
		@newfriends = current_user.unaccepted_friends
	end


	def friendadd

		Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: false)

		@friend = params[:friend_id]
	end

	def friendaccept

		f = Friendship.where(user_id: params[:friend_id], friend_id: current_user.id ).first
		f.update(status: true)
		@friend = params[:friend_id]
	end

	def frienddelete
		f = Friendship.where("user_id = ? AND friend_id = ? OR friend_id = ? AND user_id = ?",current_user , params[:friend_id],current_user, params[:friend_id]).first 
			
	    f.destroy

		@friend = params[:friend_id]
	end

	def friendprofile

		@friend = User.where(id: params[:key]).first

	end
end
