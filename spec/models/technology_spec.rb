require 'rails_helper'

RSpec.describe Technology, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:categories) }
  it_behaves_like 'a name format'

  describe '.find_by_formatted_name' do
    it 'returns technology' do
      technology = create(:technology, name: 'Technology')
      expect(Technology.find_by_formatted_name('technology')).to eq(technology)
    end

    it 'returns nil if name is nil' do
      expect(Technology.find_by_formatted_name(nil)).to be_nil
    end
  end

  describe '.find_or_initialize_by_formatted_name' do
    it 'returns technology' do
      technology = create(:technology, name: 'Technology')
      expect(Technology.find_or_initialize_by_formatted_name('technology')).to eq(technology)
    end

    it 'returns new technology' do
      expect(Technology.find_or_initialize_by_formatted_name('new-technology')).to be_a(Technology)
    end

    it 'returns nil if name is nil' do
      expect(Technology.find_or_initialize_by_formatted_name(nil)).to be_nil
    end
  end
end
