require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:repositories) }
  it { should belong_to(:technology) }
  it { should validate_uniqueness_of(:name).scoped_to(:technology_id) }
  it_behaves_like 'a name format'

  describe '.find_by_formatted_name' do
    it 'returns category' do
      category = create(:category, name: 'Category')
      expect(Category.find_by_formatted_name('category')).to eq(category)
    end

    it 'returns nil if name is nil' do
      expect(Category.find_by_formatted_name(nil)).to be_nil
    end
  end

  describe '.find_or_initialize_by_formatted_name' do
    it 'returns category' do
      category = create(:category, name: 'Category')
      expect(Category.find_or_initialize_by_formatted_name('category')).to eq(category)
    end

    it 'returns new category' do
      expect(Category.find_or_initialize_by_formatted_name('new-category')).to be_a(Category)
    end

    it 'returns nil if name is nil' do
      expect(Category.find_or_initialize_by_formatted_name(nil)).to be_nil
    end
  end
end
