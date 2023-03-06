class AnswersController < ApplicationController
  def index
    @answers = Answer.
    @questions = Question.all
    @priorities = Priority.where(user_id: current_user.id)
    # career_options for current user
    @career_options = CareerOption.where(user_id: current_user.id)
  end
end
