class UserController < ApplicationController
	#has_many :friends
	has_many :friends, Classname:friends, throught: :friendships 
	has_many :buddies, Classname:friends, throught: :friends 
end
