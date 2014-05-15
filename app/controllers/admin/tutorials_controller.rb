class Admin::TutorialsController < ApplicationController
  layout 'admin'

  before_filter :load_course
  before_action :set_tutorial, only: [:show, :edit, :update, :destroy]

  # GET /tutorials
  # GET /tutorials.json
  def index
    @tutorials = @course.tutorials.all
  end

  # GET /tutorials/1
  # GET /tutorials/1.json
  def show
  end

  # GET /tutorials/new
  def new
    @tutorial = @course.tutorials.new
  end

  # GET /tutorials/1/edit
  def edit
    setup_tags
  end

  # POST /tutorials
  # POST /tutorials.json
  def create
    process_tag_params
    @tutorial = @course.tutorials.new(tutorial_params)

    respond_to do |format|
      if @tutorial.save
        add_new_tags
        format.html { redirect_to [:admin, @course, @tutorial], notice: 'Tutorial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tutorial }
      else
        format.html { render action: 'new' }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutorials/1
  # PATCH/PUT /tutorials/1.json
  def update
    process_tag_params
    respond_to do |format|
      if @tutorial.update(tutorial_params)
        add_new_tags
        format.html { redirect_to [:admin, @course, @tutorial], notice: 'Tutorial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tutorial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutorials/1
  # DELETE /tutorials/1.json
  def destroy
    @tutorial.destroy
    respond_to do |format|
      format.html { redirect_to admin_course_tutorials_path(@course) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutorial
      @tutorial = @course.tutorials.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutorial_params
      params.require(:tutorial).permit(:title, :image_url, :description, :course_id, tag_ids: [])
    end

    # Load Course
    def load_course
      @course = Course.find(params[:course_id])
    end

    def setup_tags
      @tags = @tutorial.tags.collect do |tag|
         {value: tag.id, label: tag.name}
      end
    end

    def process_tag_params
      tags = params[:tutorial][:tag_ids].split(',')
      @new_tags = tags.collect(&:strip).reject{|s| s.to_i != 0}
      params[:tutorial][:tag_ids] = tags.collect(&:strip).reject{|s| s.to_i == 0}
    end

    def add_new_tags
      @new_tags.each {|tag| @tutorial.create_tag(tag)}
    end
end
