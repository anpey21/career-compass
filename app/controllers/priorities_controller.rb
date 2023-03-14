class PrioritiesController < ApplicationController
  def new
    @priorities = ["Salary", "Social Impact", "Work/life balance", "Location", "Status", "Stability", "Progression"]
    number_of_priorities_salary = current_user.priorities.where(priority_name: "Salary").count
    @order = (current_user.priorities.count % 7)
    @priority = Priority.new
  end

  def create
    @priority = Priority.new(priority_params)
    @priority.user = current_user
    if @priority.save
      if current_user.priorities.count == 0
        order = 1
      else
        order = (current_user.priorities.count % 7)
      end
      if order == 0
        career_option = current_user.career_options.last(2).first
        redirect_to new_career_option_answer_path(career_option)
      else
        redirect_to new_priority_path
      end
    else
      @priorities = ["Salary", "Social Impact", "Work/life balance", "Location", "Status", "Stability", "Progression"]
      @order = (current_user.priorities.count % 7)
      render :new
    end
  end

  # def edit
  #   @priority = Priority.find(params[:id])
  #   @priorities = ["Salary", "Impact", "Work/life balance", "Location", "Status", "Stability", "Progression"]
  #   @order = (current_user.priorities.count % 7)
  # end

  # def update
  #   @priority = Priority.find(params[:id])
  #   @priority.update(priority_params)
  #   redirect_to new_priority_pat
  # end

  def priority_params
    params.require(:priority).permit(:priority_name, :score)
  end
end
