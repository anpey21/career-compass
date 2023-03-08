class CareerOptionsController < ApplicationController
  def new
    @career_option = CareerOption.new
    @user = current_user
  end

  def create
    @career_option = CareerOption.new(career_options_params)
    @career_option.user = current_user
    if @career_option.save
      if current_user.career_options.count == 1
        @career_option = CareerOption.new
        redirect_to new_career_option_path
      elsif current_user.career_options.count == 2
        redirect_to root_path
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
