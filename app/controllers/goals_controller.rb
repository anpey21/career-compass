class GoalsController < ApplicationController
  def index
    @user = current_user
    @goals = @user.goals
    @goal = Goal.new
    # active goals not completed
    @active_goals = @goals.where(goal_status: "In Progress")
    # completed goals not in progress but completed or archived regardless of case
    @completed_goals = @goals.where("goal_status = ? OR goal_status = ?", "Completed", "Archived")
    # archived goals
    @archived_goals = @goals.where(goal_status: "Archived")
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    @goal.goal_status = "In Progress"
    if @goal.save
      redirect_to goals_path
    else
      raise
      render :new
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    redirect_to goals_path
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def complete_goal
    goal = Goal.find(params[:id])
    goal.goal_status = "Completed"
    goal.save
    redirect_to goals_path
  end

  private

  def goal_params
    params.require(:goal).permit(:goal_name, :goal_status, :start_value, :target_value, :current_value, :unit, :theme,
                                 :goal_completion_date)
  end
end
