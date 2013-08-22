class MessagesController < ApplicationController

	def index
		#@conversations = Conversation.where("sender_id = ? OR reciepient_id = ? ",current_user.id,  current_user.id)
		#Message.where("user_id = ? OR friend_id = ? ",current_user.id,  current_user.id).group('user_id, friend_id')
		@conversations = current_user.conversations
		@conversations += current_user.received_conversations
	end
	
	def newmsg
		@friend = User.where(id: params[:friend_id]).first
	end	

	def savenewmsg

		c = Conversation.where("(sender_id = ? AND reciepient_id = ?) OR (sender_id = ? AND reciepient_id = ?)",current_user.id,  params[:friend_id], params[:friend_id], current_user.id ).first
		
		if c.nil?
			Conversation.create(user_id: current_user.id, friend_id: params[:friend_id])
			nc = Conversation.where("(sender_id = ? AND reciepient_id = ?) OR (sender_id = ? AND reciepient_id = ?)",current_user.id,  params[:friend_id], params[:friend_id], current_user.id ).first
			Message.create(conversation_id: nc.id, user_id: current_user.id, friend_id: params[:friend_id], msg: params[:msg])
		else

			Message.create(conversation_id: c.id, sender_id: current_user.id, reciepient_id: params[:friend_id], msg: params[:msg])
		end
		
		redirect_to showconversation_path(c.id), notice: "Nachricht wurde verschickt"
	end

	def showconversation
		@conversation = Conversation.find(params[:id])
		@msgs = @conversation.messages.order('created_at desc').limit(30)
		# Message.where(conversation_id: params[:id]).order('created_at desc').all
		@message = Message.new

	end

end
