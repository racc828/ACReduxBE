class List < ApplicationRecord
  has_many :tasks
  belongs_to :project
end
