class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friends, foreign_key: "friend_id", class_name: User
end
