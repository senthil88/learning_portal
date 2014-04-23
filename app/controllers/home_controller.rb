class HomeController < ApplicationController
  skip_before_filter :verify_is_admin

  def list_courses
    @courses = Course.all
  end

  def course
    @course = Course.includes(:tutorials).find params[:id]
  end

  def tutorial
    @tutorial = Tutorial.includes(:videos).find params[:id]
  end
end
