class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :career_option
end
