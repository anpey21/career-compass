class MentorsController < ApplicationController
  def index
    @mentors = Mentor.all
    @mentors = @mentors.where(country: params[:country]) if params[:country].present?
    @mentors = @mentors.where(field: params[:field]) if params[:field].present?
    @mentors = @mentors.where("experience >= ?", params[:experience]) if params[:experience].present?
    @mentors = @mentors.where("price_per_hour <= ?", params[:price_per_hour]) if params[:price_per_hour].present?
  end

  def show
    @mentor = Mentor.find(params[:id])
  end

  def update
    @mentor = Mentor.find(params[:id])
    @mentor.update(mentor_params)
    redirect_to mentors_path
  end

  def edit
    @mentor = Mentor.find(params[:id])
  end

  private

  def mentor_params
    params.require(:mentor).permit(:photo)
  end
end
