class Priority < ApplicationRecord
  belongs_to :user
  validates :score, presence: true
end
