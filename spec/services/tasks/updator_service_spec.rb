require 'rails_helper'

RSpec.describe Tasks::UpdatorService, type: :service do
  let!(:task) { create(:task) }
  let(:params) { attributes_for(:task).except(:task) }

  let(:result) { Tasks::UpdatorService.call(task: task, params: params) }

  it 'updates task' do
    expect(result[:task].reload.attributes).to include(params.stringify_keys)
  end

  context 'when task has dependent tasks' do
    let(:delta_date) { params[:date] - task.date }

    let(:dependent_task_date) { task.date + 3.days }
    let!(:dependent_task) { create(:task, date: dependent_task_date, task: task) }

    let(:dependent_task_two_date) { dependent_task_date + 1.day }
    let!(:dependent_task_two) { create(:task, date: dependent_task_two_date, task: dependent_task) }

    it 'update dates of dependent tasks' do
      expected_dates = [dependent_task_date + delta_date, dependent_task_two_date + delta_date]
      result
      gotten_dates = [dependent_task.reload.date, dependent_task_two.reload.date]

      expect(gotten_dates).to eq(expected_dates)
    end
  end
end
