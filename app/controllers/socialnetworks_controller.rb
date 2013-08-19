class SocialnetworksController < ApplicationController

	def index 

	end

	def usersearch 		
		@user = User.all.where("firstname LIKE ? OR lastname LIKE ?", params[:key], params[:key])
	end

	def useredit


	end
end


