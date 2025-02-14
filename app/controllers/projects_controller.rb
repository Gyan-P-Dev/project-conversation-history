class ProjectsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @q = Project.ransack(params[:q])
    @projects = @q.result.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
  end  

  def new
    @project = Project.new
  end
  
  def create
    @project = current_user.projects.new(project_params)

    @project.status ||= 'open'

    if @project.save
      redirect_to projects_path, notice: "Project created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @project = Project.find(params[:id])
    @comments = @project.comments.ordered_comments.page(params[:page]).per(5)
  end
  
  def edit
    @project = Project.find(params[:id])
  end  

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully!"
  end

  private

  def project_params
    params.require(:project).permit(:name, :status, :description)
  end
end
