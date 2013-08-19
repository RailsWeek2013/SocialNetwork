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
end
