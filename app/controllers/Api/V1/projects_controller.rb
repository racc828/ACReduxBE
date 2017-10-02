class Api::V1::ProjectsController < ApplicationController

  def index
    user = current_user
    projects = user.projects
    render json: projects
  end

  def create
    project = Project.create(project_params)
    user = User.find(params[:user_id])
    user.projects << project
    render json: project
  end

  def show
    project = Project.find_by(id: params[:id])
    projectJson = {
      id:project.id,
      name:project.name,
      users: project.users,
      lists: project.lists
    }
    render json: projectJson
  end

  def update
    project = Project.find_by(id: params[:id])
    project.update(project_params)
    render json: project
  end

  def add_user
    project = Project.find_by(id: params[:id])
    user = User.find(params[:user_id])
    if project.users.include?(user)
      render json: { error: 'User Exists In Project Already' }
    else
      project.users << user
      render json: user
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])
    join = Collaborator.all.find { |collaborator| collaborator.project_id === params[:project_id] && collaborator.user_id === params[:user_id] }
    join.destroy
    project.lists.map {|list|
      list.tasks.map {|task|
        if task.users.include?(user)
           join = UserTask.all.find { |user_task| user_task.task_id === task.id && user_task.user_id === user.id }
           join.destroy
        end
      }
    }
    render json: project.users
  end

  def destroy
    project = Project.find_by(id: params[:id])
    project.lists.map{|list|
      list.tasks.map {|task|
        task.destroy
      }
    }
    project.destroy
    projects = Project.all
    render json: projects
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end

end
