class Movie < ApplicationRecord
  belongs_to :user # A saved movie belongs to a user
  has_many :reviews # One-to-many, a movie can have many reviews
  validates_associated :reviews
  validates :user, :api_id, :img_path, :title, :user_rating, presence: true # Necessary fields for a valid Movie entry
  validates :user_rating, inclusion: 0..10 # Rating needs to be between 0 and 10
  validates :api_id, numericality: {only_integer: true} # api_id can only be an int number
  # img_path can only be from API or from placeholder site
  validates :img_path, format: {with: /\A(https:\/\/image\.tmdb\.org\/t\/p\/w400\/[a-zA-Z0-9]+\.jpg)|(https:\/\/via\.placeholder\.com\/400x560\?text=[a-zA-Z0-9 ]+)\z/}

  # Fetch movie with specific api_id
  scope :saved, -> (api_id) {where("api_id= ?", api_id)}

  # Calculate average rating 
  def self.users_average(movie_api_id)
    movies = Movie.where(api_id: movie_api_id)
    sum = 0
    n = 0

    for movie in movies do
      sum += movie.user_rating
      n += 1
    end
    return sum/n
  end
end


