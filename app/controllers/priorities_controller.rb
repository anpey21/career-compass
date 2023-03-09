class PrioritiesController < ApplicationController
  def new
    @priorities = ["Salary", "Impact", "Work/life balance", "Location", "Status", "Stability", "Progression"]
    @order = current_user.priorities.count
    @priority = Priority.new
  end

  def create
    @priority = Priority.new(priority_params)
    @priority.user = current_user
    if @priority.save
      order = current_user.priorities.count
      if order == 7
        career_option = current_user.career_options.last(2).first
        redirect_to new_career_option_answer_path(career_option)
      else
        redirect_to new_priority_path
      end
    else
      render :new
    end
  end

  def priority_params
    params.require(:priority).permit(:priority_name, :score)
  end
end
