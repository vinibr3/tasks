require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { build(:task) }

  it 'has a valid factory' do
    expect(task).to be_valid
  end

  it { is_expected.to belong_to(:task).optional }
  it { is_expected.to have_many(:tasks).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to accept_nested_attributes_for(:tasks) }
end
