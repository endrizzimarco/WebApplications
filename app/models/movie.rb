class Movie < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates_associated :reviews
  validates :user, :api_id, :img_path, :user_rating, presence: true

  scope :saved, -> (api_id) {where("api_id= ?", api_id)}
end


