class AnswersController < ApplicationController
  def new
    @answer = Answer.new
    @career_option = CareerOption.find(params[:career_option_id])
    @career_options = CareerOption.where(user_id: current_user.id).last(2)
  end

  def create
    @career_options = CareerOption.where(user_id: current_user.id).last(2)
    # @first_career_option = @career_options[-2]
    # @second_career_option = @career_options[-1]
    @questions = Question.all
    @questions.each do |question|
      @answer = Answer.new(score: params[question.question], question: question, career_option_id: params[:career_option_id])
      @answer.save
    end

    if params[:career_option_id].to_i == @career_options.first.id
      redirect_to new_career_option_answer_path(@career_options.last)
    else
      redirect_to answers_path
    end
  end

  def index
    @career_options = CareerOption.where(user_id: current_user.id)
    @first_career_option = @career_options[-2]
    @second_career_option = @career_options[-1]
    @first_answer = Answer.where(career_options: @first_career_option.id)
    @second_answer = Answer.where(career_options: @second_career_option.id)
    @questions = Question.all
    @priorities = Priority.where(user_id: current_user.id)
    @priority_names = @priorities.pluck(:priority_name)

    # return array of arrays with priority_id and priority score
    @priorities_plucked = @priorities.pluck(:id, :score)

    # return array of arrays with priority name and answer score
    @priorities_plucked_with_names = @priorities.pluck(:priority_name, :score)
    # return array of priority names ordered by score from highest to lowest with scores
    @priorities_plucked_with_names_ordered_by_score = @priorities_plucked_with_names.sort_by do |_priority_name, score|
      score
    end.reverse

    # priority names ordered by score from highest to lowest
    @priorities_names_ordered_by_score = @priorities_plucked_with_names.sort_by do |_priority_name, score|
                                           score
                                         end.reverse.map { |priority_name, _score| priority_name }

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
      @first_career_option.option.capitalize => @first_total_score,
      @second_career_option.option.capitalize => @second_total_score
    }

    # return top career option
    @top_career_option = @career_options_and_scores.max_by { |_key, value| value }[0]

    # create a hash of the weighted answer scores for each career option and priority
    @first_weighted_answer_hash = @priority_names.zip(first_weighted_answer).to_h
    @second_weighted_answer_hash = @priority_names.zip(second_weighted_answer).to_h
    @first_weighted_answer_hash_transformed_with_job_title = { option: @first_career_option.option,
                                                               data: @first_weighted_answer_hash }
    @second_weighted_answer_hash_transformed_with_job_title = { option: @second_career_option.option,
                                                                data: @second_weighted_answer_hash }
    @weighted_answers = [@first_weighted_answer_hash, @second_weighted_answer_hash]
    @weighted_answers_with_job_title = [@first_weighted_answer_hash_transformed_with_job_title,
                                        @second_weighted_answer_hash_transformed_with_job_title]
    # returning the total possible score
    @total_possible_score = total_possible_score

    # returning the percentage of the total possible score
    @first_percentage = ((@first_total_score.to_f / @total_possible_score) * 100).round(1)
    @second_percentage = ((@second_total_score.to_f / @total_possible_score) * 100).round(1)
  end

  # convert question_id to priority_id
  def convert_question_to_priority(answer)
    answer.map do |question_id, score|
      score = score.to_i
      priority_id = Question.find(question_id).priority_id
      [priority_id, score]
    end
  end

  # multiply answer score by priority score
  def weighted_answer(answer)
    answer.map do |priority_id, score|
      priority_score = @priorities_plucked.select { |id, _score| id == priority_id }.flatten[1].to_i
      score * priority_score
    end
  end

  # returning the total possible score
  def total_possible_score
    total_priority = @priorities.sum(:score)
    answer_quantity = Answer.where(career_options: @first_career_option.id).count
    total_priority * answer_quantity
  end
end

# salary
# impact
# balance
# location
# status
# stability
# progression
