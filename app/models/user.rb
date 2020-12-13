class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movies, dependent: :destroy # One-to-many, a user can have many saved movies
  validates_associated :movies
  has_many :reviews, dependent: :destroy # One-to-many, a user can have many reviews
  validates_associated :reviews
  has_many :favourites, dependent: :destroy # One-to-many, a user can have many favourite movies
  has_many :favourite_movies, through: :favourites, source: :favourited, source_type: 'Movie'
  validates_associated :favourite_movies
end
