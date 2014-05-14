class TutorialsController < ApplicationController
  skip_before_filter :verify_is_admin

  def show
    @tutorial = Tutorial.includes(:videos).find params[:id]
  end
end
