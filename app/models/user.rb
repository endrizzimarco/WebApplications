class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movies, dependent: :destroy
  validates_associated :movies
  has_many :reviews, dependent: :destroy
  validates_associated :reviews
  has_many :favourites, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :favourited, source_type: 'Movie'
  validates_associated :favourite_movies
end
