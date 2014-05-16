class CoursesController < ApplicationController
  skip_before_filter :verify_is_admin

  def index
    @tutorials = Tutorial.includes(:course, :videos)
  end

  def show
    @course = Course.friendly.find(params[:id])
    @tutorials = @course.tutorials
    render "index"
  end
end
