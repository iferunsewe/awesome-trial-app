class Category < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :technology_id

  before_save :downcase_and_hyphenate_name

  has_many :repositories
  belongs_to :technology

  def self.find_by_downcased_and_hyphenated_name(name)
    self.find_by(name: name.downcase.gsub(' ', '-'))
  end

  private

  def downcase_and_hyphenate_name
    return if self.name.nil?
    self.name = self.name.downcase.gsub(' ', '-')
  end
end
