class Message < ActiveRecord::Base
	belongs_to :conversation
	belongs_to :reciepient, class_name: User
	belongs_to :sender, class_name: User
end
