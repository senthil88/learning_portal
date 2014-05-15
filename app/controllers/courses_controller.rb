class CoursesController < ApplicationController
  skip_before_filter :verify_is_admin

  def index
    @tutorials = Tutorial.includes(:videos)
  end

  def show
    @course = Course.find_by_id(params[:id])
    @tutorials = @course.tutorials
    render "index"
  end
end
