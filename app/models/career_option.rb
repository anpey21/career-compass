class CareerOption < ApplicationRecord
  has_many :answers
  belongs_to :user
  validates :option, presence: true
  validates :option, length: { minimum: 3}
end
