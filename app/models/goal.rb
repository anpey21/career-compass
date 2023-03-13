class Goal < ApplicationRecord
  belongs_to :user
  validates :goal_name, presence: true
  validates :start_value, presence: true
  validates :current_value, presence: true
  validates :target_value, presence: true
  validates :unit, presence: true
  validates :goal_status, presence: true
  validates :theme, presence: true
  validates :goal_completion_date, presence: true
end
