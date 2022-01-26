module NameFormat
  extend ActiveSupport::Concern

  included do
    before_save :format_name
  end

  def format_name
    return if self.name.nil?
    self.name = self.name.downcase.gsub(' ', '-')
  end

  class_methods do
    def find_by_formatted_name(name)
      return nil if name.nil?
      self.find_by(name: name.downcase.gsub(' ', '-'))
    end

    def find_or_initialize_by_formatted_name(name)
      return nil if name.nil?
      self.find_or_initialize_by(name: name.downcase.gsub(' ', '-'))
    end
  end
end
