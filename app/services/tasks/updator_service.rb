# frozen_string_literal: true

class Tasks::UpdatorService < ApplicationService
  def call
    ActiveRecord::Base.transaction do
      return { error: @task.errors.full_messages.join(', ') } unless @task.update(@params)

      update_dates_of_dependent_tasks if @task.date != @former_date

      {task: @task}
    end
  end

  private

  def initialize(args)
    @task = args[:task]
    @former_date = @task.date
    @params = args[:params]
  end

  def update_dates_of_dependent_tasks
    delta_date = @task.date - @former_date

    @task.tasks.each {|t| update_date_of_task(t, delta_date) }
  end

  def update_date_of_task(task, delta_date)
    task.tasks.each {|t| update_date_of_task(t, delta_date) }
    task.update(date: task.date + delta_date)
  end
end
