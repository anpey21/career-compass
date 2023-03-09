class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @user = current_user
    @career_options = CareerOption.where(user_id: current_user.id)
    @answers = Answer.where(career_options: @career_options.ids)
  end
end
