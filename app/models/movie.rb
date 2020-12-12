class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates_associated :reviews
  validates :user, :api_id, :img_path, :title, :user_rating, presence: true
  validates :user_rating, inclusion: 0..10
  validates :api_id, numericality: {only_integer: true}
  validates :img_path, format: {with: /\A(https:\/\/image\.tmdb\.org\/t\/p\/w400\/[a-zA-Z0-9]+\.jpg)|(https:\/\/via\.placeholder\.com\/400x560\?text=[a-zA-Z0-9 ]+)\z/}

  scope :saved, -> (api_id) {where("api_id= ?", api_id)}

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


