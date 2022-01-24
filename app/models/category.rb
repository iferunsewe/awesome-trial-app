class Category < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :technology_id

  has_many :repositories
  belongs_to :technology
end
