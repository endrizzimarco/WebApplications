class Review < ApplicationRecord
    belongs_to :user # A review belongs to a user 
    belongs_to :movie # A saved movie belongs to a user 
    validates :user, :movie, :comment, :movie_api_id, presence: true # Necessary fields for a valid Review entry

    # Fetches the last 4 reviews for a movie
    scope :recent, -> (api_id) { where("movie_api_id= ?",  api_id).order("created_at DESC").first(4)}
end