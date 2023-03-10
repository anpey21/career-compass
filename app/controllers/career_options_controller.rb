class CareerOptionsController < ApplicationController
  def new
    @career_option = CareerOption.new
    @user = current_user
  end

  def create
    @career_option = CareerOption.new(career_options_params)
    @career_option.user = current_user
    if @career_option.save
      if current_user.career_options.count.odd?
        @career_option = CareerOption.new
        redirect_to new_career_option_path
      elsif current_user.career_options.count.even?
        redirect_to new_priority_path
      end
    else
      render :new
    end
  end

  private

  def career_options_params
    params.require(:career_option).permit(:option)
  end
end
