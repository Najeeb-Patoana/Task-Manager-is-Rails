
class TasksController < ApplicationController
  # READ: Show all tasks
  def index
    @tasks = Task.order(created_at: :desc)
  end

  # READ: Show one task
  def show
    @task = Task.find(params[:id])
  end

  # Display the empty form
  def new
    @task = Task.new
  end

  # CREATE: Receive form data and save a task
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "Task created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Display the form for editing
  def edit
    @task = Task.find(params[:id])
  end

  # UPDATE: Save changes to an existing task
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to @task, notice: "Task updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE: Remove a task
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  private

  # Permit only the fields that users may submit
  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :status,
      :due_date
    )
  end
end
