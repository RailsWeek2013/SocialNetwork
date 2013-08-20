class UserController < ApplicationController
	def userprofile
		@user_profile = current_user
		@pins = Pinboard.where(friend_id: current_user.id).order('created_at desc').all
	end

	def edituser
		if current_user.update(profile_params)
			redirect_to userprofile_path, notice: "Erfolgreich geändert."
		else
			redirect_to userprofile_path, notice: "Es ist ein Fehler aufgetreten."
		end

	end

	private
	def profile_params
      params.require(:user).permit(:firstname, :lastname, :email, :birthday)
    end

end
