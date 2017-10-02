class Api::V1::TasksController < ApplicationController

  def index
    tasks = Task.all
    render json: tasks
  end

  def create
    task = Task.create(task_params)
    list = List.find(params[:list_id])
    list.tasks << task
    render json: task
  end

  def show
    task = Task.find_by(id: params[:id])
    # tasksJson = {
    #   completed: task.completed,
    #   id: task.id,
    #   description:task.description,
    #   list_id: task.list_id,
    #   name: task.name,
    #   positionX: task.positionX,
    #   positionY: task.positionY,
    #   users: task.users
    # }
    render json: task
  end

  def add_user
    task = Task.find_by(id: params[:id])
    user = User.find(params[:user_id])
    if task.users.include?(user)
      render json: { error: 'User has already been assigned this task' }
    else
      task.users << user
      render json: user
    end
  end

  def update
    task = Task.find_by(id: params[:id])
    task.update(task_params)
    render json: task
  end

  def delete_user
    user = User.find(params[:user_id])
    task = Task.find(params[:task_id])
    join = UserTask.all.find { |user_task| user_task.task_id === params[:task_id] && user_task.user_id === params[:user_id] }
    join.destroy
    render json: task.users
  end

  def get_tasks
    user = User.find(params[:user_id])
    render json: user.tasks
  end

  def destroy
    task = Task.find_by(id: params[:id])
    task.destroy
    tasks = Task.all
    render json: tasks
  end

  private

  def task_params
    params.require(:task).permit(:name, :list_id, :description, :positionX, :positionY)
  end

end
