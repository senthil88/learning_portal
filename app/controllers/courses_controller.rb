class CoursesController < ApplicationController
  skip_before_filter :verify_is_admin

  def index
    @courses = Course.all
  end

  def show
    @course = Course.includes(:tutorials).find params[:id]
  end
end
