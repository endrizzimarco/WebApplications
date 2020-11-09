class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movies
  has_many :favourites
  has_many :favourite_movies, through: :favourites, source: :favourited, source_type: 'Movie'
end
