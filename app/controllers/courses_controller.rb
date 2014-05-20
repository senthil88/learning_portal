class CoursesController < ApplicationController
  skip_before_filter :verify_is_admin

  def index
    if params[:search]
      @tag = Tag.find_by_name params[:search]
      @tutorials = @tag.present? ? @tag.tutorials.includes(:course, :videos) : nil
    else
      @tutorials = Tutorial.includes(:course, :videos)
    end
  end

  def show
    @course = Course.friendly.find(params[:id])
    @tutorials = @course.tutorials
    render "index"
  end
end
