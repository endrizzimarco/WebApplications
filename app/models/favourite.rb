class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :favourited, polymorphic: true
  validates :user, :favourited, presence: true
end
