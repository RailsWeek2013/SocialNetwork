class FriendController < ApplicationController

	def friendhome

		@friends = current_user.accepted_friends
		@newfriends = current_user.unaccepted_friends
	end


	def friendadd

		f = Friendship.where(user_id: current_user.id, friend_id: params[:friend_id]).first

		unless f.nil?
			redirect_to friend_path, notice: f.status ? "Anfrage bereits bestätigt" : "Anfrage schon gesendet"
		else
			Friendship.create(user_id: current_user.id, friend_id: params[:friend_id], status: false)

			redirect_to friend_path, notice: "Anfrage wurde verschickt"
		end

		@friend = params[:friend_id]
	end

	def friendaccept

		f = Friendship.where(user_id: params[:friend_id], friend_id: current_user.id ).first
		f.update(status: true)
		@friend = params[:friend_id]

		redirect_to friendprofile_path(params[:friend_id]), notice: "Freund wurde hinzugefügt"
	end

	def frienddenie

		f = Friendship.where(user_id: params[:friend_id], friend_id: current_user.id ).first
		f.destroy

		redirect_to friend_path, notice: "Anfrage verweigert"
	end

	def frienddelete

		c = Conversation.where("(sender_id = ? AND reciepient_id = ?) OR (sender_id = ? AND reciepient_id = ?)",current_user.id,  params[:friend_id], params[:friend_id], current_user.id ).first
		unless c.nil?
			m = Message.where(conversation_id: c.id)
			m.destroy_all
			c.destroy	
		end
		f = Friendship.where("user_id = ? AND friend_id = ? OR friend_id = ? AND user_id = ?",current_user , params[:friend_id],current_user, params[:friend_id]).first 
	    f.destroy

		redirect_to friend_path, notice: "Freund wurde erfolgreich gelöscht"
	end

	def friendprofile

		@friend = User.find(params[:key])
		@pins = Pinboard.where(user_id: current_user.id, friend_id: params[:key]).order('created_at desc').all
	end

	def friendnewpinentry

		Pinboard.create(user_id: current_user.id, friend_id: params[:friend_id], entry: params[:msg])

		redirect_to friendprofile_path(params[:friend_id]), notice: "Pinwandeintrag wurde erfolgreich erstellt"
	end

	def frienddeletepinentry
		
		p = Pinboard.find(params[:pin_id])
		p.destroy

		redirect_to userprofile_path, notice: "Pinwandeintrag wurde erfolgreich gelöscht"
	end
end
