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

		redirect_to friendprofile_path(key: params[:friend_id]), notice: "Freund wurde hinzugefügt"
	end

		def frienddenie

		f = Friendship.where(user_id: params[:friend_id], friend_id: current_user.id ).first
		f.destroy

		redirect_to friend_path, notice: "Anfrage verweigert"
	end

	def frienddelete
		f = Friendship.where("user_id = ? AND friend_id = ? OR friend_id = ? AND user_id = ?",current_user , params[:friend_id],current_user, params[:friend_id]).first 
			
	    f.destroy

		redirect_to friend_path, notice: "Freund wurde erfolgreich gelöscht"
	end

	def friendprofile

		@friend = User.where(id: params[:key]).first
		@pins = Pinboard.where(user_id: current_user.id, friend_id: params[:key]).order('created_at desc').all
	end

	def friendnewpinentry
		Pinboard.create(user_id: current_user.id, friend_id: params[:friend_id], entry: params[:msg])

		redirect_to friendprofile_path(key: params[:friend_id]), notice: "Pinwandeintrag wurde erfolgreich erstellt"
	end

	def frienddeletepinentry
		p = Pinboard.where(id: params[:pin_id]).first
		p.destroy

		redirect_to userprofile_path, notice: "Pinwandeintrag wurde erfolgreich gelöscht"
	end
end
