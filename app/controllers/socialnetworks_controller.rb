class SocialnetworksController < ApplicationController

	def index 

		@post = Post.new
		@posts = Array.new

		limit = 15

		Friendship.where(user_id: current_user).map { |f| @posts += f.friend.posts.limit(limit) }

		#if @posts.count < 0
			Friendship.where(friend_id: current_user).map { |f| @posts += f.friend.posts.limit(limit) }
		#end

		@posts += current_user.posts.limit(limit)
		@posts.sort! do |a,b| 
			b.created_at <=> a.created_at
		end
	end

	def usersearch 		
		@user = User.all.where("firstname LIKE ? OR lastname LIKE ?", params[:key], params[:key])
	end

	def createpost

		@post = Post.new(post_params)
		@post.user = current_user
		
		if @post.save
			redirect_to root_path, notice: "Post wurde erstellt :-)"
		else
			redirect_to root_path, notice: "Post NICHT erstellt. Titel und Text angegeben???"
		end
	end

	def likepost
		
		l = Like.new
		l.user_id = params[:u_id]
		l.post_id = params[:p_id]

		if l.save
			redirect_to root_path, notice: "Du hast einen Beitrag geliked :-)"
		else
			redirect_to root_path, notice: "Es konnte NICHT geliked werden..."
		end

		
	end

	def deletepost

		if Post.find(params[:p_id]).delete
			redirect_to root_path, notice: "Post wurde gelöscht :-)"
		else
			redirect_to root_path, notice: "Es ist ein FEHLER aufgetreten..."
		end
		
	end

	private
	def post_params
      params.require(:post).permit(:title, :message)
    end
end
