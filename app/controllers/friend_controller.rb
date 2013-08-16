class FriendController < ApplicationController

	def friendhome
		@friends = Friendship.all.where(user_id: current_user.id)
	end

	def friendadd

		Friendship.create(user_id: current_user.id, friend_id: params[:friend_id])

		@friend = params[:friend_id]
	end

	def frienddelete
		f = current_user.friend.find(params[:friend])
#	    f = Friend.all.where(user: current_user.id, friend: params[:friend_id])
#	    f.destroy
		puts f.inspect
		@friend = params[:friend_id]
	end


	def getfriendships

	end
end
