class Post < ActiveRecord::Base
	belongs_to :user
	has_many :likes
	has_many :users, through: :likes
	has_many :comments

	validates :title, presence: true
	validates :message, presence: true
end
