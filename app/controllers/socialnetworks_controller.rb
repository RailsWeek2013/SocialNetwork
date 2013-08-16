class SocialnetworksController < ApplicationController

	def index 
		
	end

	def usersearch 		
			@user = User.where("firstname LIKE ?", params[:key]	)
	end
end


