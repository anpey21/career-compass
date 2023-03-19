class Mentor < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  validates :first_name, presence: true
  validates :bio, presence: true
end
