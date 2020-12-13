class Favourite < ApplicationRecord
  belongs_to :user # User can have multiple favourite movies
  belongs_to :favourited, polymorphic: true # This implementation permits multiple type of favourites to be added in the future
  validates :user, :favourited, presence: true # Necessary fields for a valid Favourite entry
end
