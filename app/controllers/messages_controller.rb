class MessagesController < ApplicationController

	def index
	
		@conversations = current_user.conversations
		@conversations += current_user.received_conversations
	end
	
	def new

		@friend = User.find(params[:user_id])
		@message = Message.new
	end

	def create

		m = Message.new(params.require(:message).permit(:msg))
					
		m.sender =current_user
		m.reciepient_id = params[:user_id]
	
		c = Conversation.where("(sender_id = ? AND reciepient_id = ?) OR (sender_id = ? AND reciepient_id = ?)",current_user.id,  params[:user_id], params[:user_id], current_user.id ).first
		c = Conversation.create(sender_id: current_user.id, reciepient_id: params[:user_id]) if c.nil?		
		m.conversation = c

		m.save

		redirect_to showconversation_path(c.id), notice: "Nachricht wurde verschickt"
	end

	def showconversation

		@conversation = Conversation.find(params[:id])
		@msgs = @conversation.messages.order('created_at desc').limit(30)
		@message = Message.new
	end
end
