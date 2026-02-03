# frozen_string_literal: true

class Api::V1::TasksController < ActionController::API
  def index
    tasks = Task.page(params[:page])
                .per(params[:per_page])

    render json: { tasks: tasks,
                   total_pages: tasks.total_pages,
                   current_page: tasks.current_page,
                   next_page: tasks.next_page,
                   prev_page: tasks.prev_page }
  end

  def create
    task = Task.new(task_params)

    render(json: task) and return if task.save

    render json: { error: task.errors.full_messages.join(', ') },
           status: :unprocessable_entity
  end

  def update
    task = Task.find(params[:id])
    result = Tasks::UpdatorService.call(task: task, params: task_params)

    render(json: result.slice(:error),
           status: :unprocessable_entity) and return if result[:error].present?

    render json: result[:task]
  end

  def destroy
    task = Task.find(params[:id])

    head :no_content and return if task.destroy
  end

  private

  def task_params
    params.require(:task)
          .permit(:title, :date, tasks_attributes: [:title, :date])
  end
end
