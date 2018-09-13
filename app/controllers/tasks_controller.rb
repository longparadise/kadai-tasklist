class TasksController < ApplicationController
  
  def index
    if logged_in?
      @tasks = current_user.tasks.page(params[:page])
    end
  end
  
  def show
    if logged_in?
      @task = current_user.tasks.find(params[:id])
    end
  end
  
  def new
    if logged_in?
      @task = current_user.tasks.new
    end
  end
  
  def create
    if logged_in?
      @task = current_user.tasks.new(task_params)
    
      if @task.save
        flash[:success] = 'Taskが正常に投稿されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Taskが投稿されませんでした'
        render :new
      end
    end
  end
  
  def edit
    if logged_in?
      @task = current_user.tasks.find(params[:id])
    end
  end
  
  def update
    if logged_in?
      @task = current_user.tasks.find(params[:id])
    
      if @task.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Taskは更新されませんでした'
        render :edit
      end
    end
  end
  
  def destroy
    if logged_in?
      @task = current_user.tasks.find(params[:id])
      @task.destroy
    
      flash[:success] = 'Taskは正常に削除されました'
      redirect_to tasks_url
    end
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
