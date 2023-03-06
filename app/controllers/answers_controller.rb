class AnswersController < ApplicationController
  def index
    @career_options = CareerOption.where(user_id: current_user.id)
    @first_career_option = @career_options[-2]
    @second_career_option = @career_options[-1]
    @first_answer = Answer.where(career_options: @first_career_option.id)
    @second_answer = Answer.where(career_options: @second_career_option.id)
    @questions = Question.all
    @priorities = Priority.where(user_id: current_user.id)
    priority_names = @priorities.pluck(:priority_name)

    # return array of arrays with priority_id and priority score
    @priorities_plucked = @priorities.pluck(:id, :score)

    # return array of arrays with question_id and answer score
    first_answer = @first_answer.pluck(:question_id, :score)
    second_answer = @second_answer.pluck(:question_id, :score)

    # convert question_id to priority_id
    first_answer_priority = convert_question_to_priority(first_answer)
    second_answer_priority = convert_question_to_priority(second_answer)

    # multiply answer score by priority score
    first_weighted_answer = weighted_answer(first_answer_priority)
    second_weighted_answer = weighted_answer(second_answer_priority)

    # sum all weighted scores
    @first_total_score = first_weighted_answer.sum
    @second_total_score = second_weighted_answer.sum

    # create a hash of the two career options and their total scores
    @career_options_and_scores = {
      @first_career_option.option => @first_total_score,
      @second_career_option.option => @second_total_score
    }

    # create a hash of the weighted answer scores for each career option and priority
    @first_weighted_answer_hash = priority_names.zip(first_weighted_answer).to_h
    @second_weighted_answer_hash = priority_names.zip(second_weighted_answer).to_h

    raise
  end

  def convert_question_to_priority(answer)
    answer.map do |question_id, score|
      score = score.to_i
      priority_id = Question.find(question_id).priority_id
      [priority_id, score]
    end
  end

  def weighted_answer(answer)
    answer.map do |priority_id, score|
      priority_score = @priorities_plucked.select { |id, _score| id == priority_id }.flatten[1].to_i
      weighted_score = score * priority_score
    end
  end
end

# salary
# impact
# balance
# location
# status
# stability
# progression
