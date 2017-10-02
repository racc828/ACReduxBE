class Project < ApplicationRecord
  has_many :collaborators
  has_many :users, through: :collaborators
  has_many :lists
end
