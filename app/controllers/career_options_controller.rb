class CareerOptionsController < ApplicationController

  def create
    @career_option = CareerOption.new(career_option_params)
    @career_option.user = current_user
    if @career_option.save
      redirect_to new_answer_path
    else
      render :new
    end
  end

  private

  def career_option_params
    params.require(:career_option).permit(:name, :description, :user_id)
  end
end
