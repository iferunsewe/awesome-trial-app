class Technology < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :downcase_and_hyphenate_name
  
  has_many :categories

  def self.find_by_downcased_and_hyphenated_name(name)
    self.find_by(name: name.downcase.gsub(' ', '-'))
  end

  private

  def downcase_and_hyphenate_name
    return if self.name.nil?
    self.name = self.name.downcase.gsub(' ', '-')
  end
end
