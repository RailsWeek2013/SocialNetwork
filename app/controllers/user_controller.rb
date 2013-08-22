class UserController < ApplicationController
	def userprofile
		@user_profile = current_user
		@pins = Pinboard.where(friend_id: current_user.id).order('created_at desc').all

		#uploader = AvatarUploader.new
		#uploader.store!(my_file)
		#uploader.retrieve_from_store!('my_file.png')

	end

	def edituser
		
		current_user.update(profile_params)
		redirect_to userprofile_path, notice: "Erfolgreich geändert."
	end

	private
	def profile_params
      params.require(:user).permit(:firstname, :lastname, :email, :birthday, :avatar)
    end

end
