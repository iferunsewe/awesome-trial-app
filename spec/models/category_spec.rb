require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:repositories) }
  it { should belong_to(:technology) }
  it { should validate_uniqueness_of(:name).scoped_to(:technology_id) }
end
