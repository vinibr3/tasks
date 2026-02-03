require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:response_body) { JSON.parse(response.body) }

  describe 'GET index' do
    let!(:tasks) { create_list(:task, 2) }

    it 'returns paginated tasks' do
      get :index, params: { page: 2, per_page: 1 }

      expect(response.body).to eq({tasks: [tasks.second],
                                   total_pages: 2,
                                   current_page: 2,
                                   next_page: nil,
                                   prev_page: 1}.to_json)
    end

    it 'response have http status ok' do
      get :index, params: { page: 2, per_page: 1 }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    context 'when params are valids' do
      let(:attributes) { attributes_for(:task) }
      let(:attributes_two) { attributes_for(:task).except(:task) }
      let(:params) { { task: { title: attributes[:title],
                               date: attributes[:date].strftime('%Y/%m/%d'),
                               tasks_attributes: [{ title: attributes_two[:title],
                                                    date: attributes_two[:date].strftime('%Y/%m/%d') }] } } }

      it 'returns serialized created task' do
        post :create, params: params

        task = Task.first
        serialized_attributes = response_body.except('created_at', 'updated_at')

        expect(serialized_attributes).to eq({ id: task.id,
                                              task_id: nil,
                                              title: params[:task][:title],
                                              date: params[:task][:date].to_date.to_s }.stringify_keys)
      end

      it 'creates dependent tasks' do
        post :create, params: params

        task = Task.first
        dependent_tasks = task.tasks

        expect(dependent_tasks.first.attributes).to include(attributes_two.stringify_keys)
      end

      it 'response have http status ok' do
        post :create, params: params

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when params are not valids' do
      let(:params) { { task: { title: '', date: '' } } }

      it 'returns errors' do
        post :create, params: params

        expect(response_body).to eq({ error: "Title can't be blank, Date can't be blank" }.stringify_keys)
      end

      it 'response have http status unprocessable_entity' do
        post :create, params: params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH update' do
    let!(:task) { create(:task) }
    let(:params) { { task: attributes_for(:task).except(:task) } }

    it 'updates task' do
      patch :update, params: params.merge(id: task.id)

      expect(task.reload.attributes).to include(params[:task].stringify_keys)
    end

    context 'when params are not valids' do
      let(:params) { { task: attributes_for(:task).transform_values{|v| '' } } }

      it 'returns errors' do
        patch :update, params: params.merge(id: task.id)

        expect(response_body).to eq({ error: "Title can't be blank, Date can't be blank" }.stringify_keys)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:task) { create(:task) }
    let!(:dependent_task) { create(:task, task: task) }

    it 'destroys task and dependent tasks' do
      expect{
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).from(2).to(0)
    end

    it 'response have http status no_content' do
      delete :destroy, params: { id: task.id }

      expect(response).to have_http_status(:no_content)
    end
  end
end
