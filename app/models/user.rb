class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :friendships
  has_many :friends, class_name: User, through: :friendships
  has_many :posts
  has_many :likes
  has_many :favourites, through: :likes, foreign_key: 'post_id'
  has_many :pinboards


  def accepted_friends 
    f = Friendship.where("user_id = ? AND status = ? or friend_id = ? AND status = ?", self,true, self, true) 

    f.map { |fs| 
      if fs.friend_id == self.id
        fs.user
      else
        fs.friend
      end
    }
  end 

  def unaccepted_friends
    Friendship.where(friend_id: self, status: false).map { |fs| fs.user }
  end 
end

