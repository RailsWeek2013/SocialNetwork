class Conversation < ActiveRecord::Base
	belongs_to :sender, class_name: User 
	belongs_to :reciepient, class_name: User
	has_many :messages
end
