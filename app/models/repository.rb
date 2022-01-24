class Repository < ApplicationRecord
  validates_presence_of :name, :owner, :project_info
  validates_uniqueness_of :name, scope: [:category_id]

  belongs_to :category
end
