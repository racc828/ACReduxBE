class Task < ApplicationRecord
  belongs_to :list
  has_many :user_tasks
  has_many :users, through: :user_tasks
end
