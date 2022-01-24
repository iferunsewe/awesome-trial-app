require 'rails_helper'

RSpec.describe Repository, type: :model do
  let(:repository) { create(:repository) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:project_info) }
  it { should belong_to(:category) }
  it { should validate_uniqueness_of(:name).scoped_to([:category_id]) }
end
