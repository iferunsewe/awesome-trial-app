require 'rails_helper'

RSpec.describe Repository, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:category) }

  it 'should validate the uniqueness of name scoped to category_id' do
    category = create(:category, technology: build(:technology))
    repository = create(:repository, category: category)
    expect(build(:repository, name: repository.name, category: category)).to_not be_valid
  end

  it 'should validate name structure' do
    repository = build(:repository, name: 'owner/repository', category: build(:category))
    expect(repository.valid?).to be(true)
    invalid_repository = build(:repository, name: 'owner/repository/invalid', category: build(:category))
    expect(invalid_repository.valid?).to be(false)
  end
end
