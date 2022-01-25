class Technology < ApplicationRecord
  include NameFormat

  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_many :categories
end
