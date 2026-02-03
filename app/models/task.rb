# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :task, optional: true

  has_many :tasks, dependent: :destroy

  validates :title, presence: true,
                    length: { maximum: 255 }
  validates :date, presence: true

  accepts_nested_attributes_for :tasks, reject_if: :all_blank
end
