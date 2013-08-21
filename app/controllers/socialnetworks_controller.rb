class SocialnetworksController < ApplicationController

	def index 

		@post = Post.new
		@posts = Array.new
		@likes = User.find(current_user).likes.map{|l| l.post_id}
		limit = 15

		Friendship.where(user_id: current_user, status: true).map { |f| @posts += f.friend.posts.limit(limit) }
		Friendship.where(friend_id: current_user, status: true).map { |f| @posts += f.user.posts.limit(limit) }
		

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
		l.user = current_user
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

	def commentpost
		
		limit = 30
		@post = Post.find_by_id(params[:p_id])
		@comment = Comment.new
		@post_comments = Comment.where(post_id: params[:p_id]).order('created_at desc').limit(limit)
	end

	def addcomment
		
		comment = Comment.new(comment_params)

		if comment.save
			redirect_to commentpost_path(comment.post_id), notice: "Kommentar hinzugefügt :-)"
		else
			redirect_to commentpost_path(comment.post_id), notice: "Ein Fehler ist aufgetreten: Text eingegeben?"
		end
	end

	def deletecomment
		
		comment = Comment.find_by_id(params[:c_id])

		if comment.destroy
			redirect_to commentpost_path(params[:p_id]), notice: "Kommentar wurde entfernt"
		else
			redirect_to commentpost_path(params[:p_id]), notice: "Ein Fehler beim entfernen des Kommentars ist aufgetreten"
		end

		
	end

	private
	def post_params
     	params.require(:post).permit(:title, :message)
    end

    def comment_params
    	params.require(:comment).permit(:comment, :user_id, :post_id)
    end
end
