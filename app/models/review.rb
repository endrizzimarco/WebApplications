class Review < ApplicationRecord
    belongs_to :user
    belongs_to :movie
    validates :user, :movie, :comment, :movie_api_id, presence: true

    scope :recent, -> (api_id) { where("movie_api_id= ?",  api_id).order("created_at DESC").first(4)}
end