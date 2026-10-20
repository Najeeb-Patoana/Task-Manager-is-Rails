
# class TasksController < ApplicationController
#     skip_forgery_protection
#   before_action :set_task, only: %i[show update destroy]

#   # GET /tasks
#   def index
#     render json: Task.order(created_at: :desc),
#            status: :ok
#   end

#   # GET /tasks/:id
#   def show
#     render json: @task, status: :ok
#   end

#   # POST /tasks
#   def create
#     task = Task.new(task_params)

#     if task.save
#       render json: task, status: :created
#     else
#       render json: { errors: task.errors.full_messages },
#              status: :unprocessable_entity
#     end
#   end

#   # PATCH /tasks/:id or PUT /tasks/:id
#   def update
#     if @task.update(task_params)
#       render json: @task, status: :ok
#     else
#       render json: { errors: @task.errors.full_messages },
#              status: :unprocessable_entity
#     end
#   end

#   # DELETE /tasks/:id
#   def destroy
#     @task.destroy!
#     head :no_content
#   end

#   private

#   # Find task before show, update, or destroy
#   def set_task
#     @task = Task.find_by(id: params[:id])

#     return if @task

#     render json: { error: "Task not found" },
#            status: :not_found
#   end

#   # Allow only permitted fields from the request body
#   def task_params
#     params.require(:task).permit(
#       :title,
#       :description,
#       :status,
#       :due_date
#     )
#   end
# end


class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.json { render json: @tasks, status: :ok }
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/:id
  def show
    respond_to do |format|
      format.html
      format.json { render json: @task, status: :ok }
    end
  end

  # GET /tasks/:id/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      respond_to do |format|
        format.html do
          redirect_to task_path(@task), notice: "Task created successfully."
        end

        format.json { render json: @task, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: { errors: @task.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH /tasks/:id
  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html do
          redirect_to task_path(@task), notice: "Task updated successfully."
        end

        format.json { render json: @task, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: { errors: @task.errors.full_messages },
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html do
        redirect_to tasks_path, notice: "Task deleted successfully."
      end

      format.json { head :no_content }
    end
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])

    return if @task

    respond_to do |format|
      format.html do
        redirect_to tasks_path, alert: "Task not found."
      end

      format.json do
        render json: { error: "Task not found" },
               status: :not_found
      end
    end
  end

  def task_params
    params.require(:task).permit(
      :title,
      :description,
      :status,
      :due_date
    )
  end
end
