require 'rails_helper'

RSpec.describe Repository, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:category) }
  it_behaves_like 'a name format'

  let(:github_repository_handler) { instance_double(GithubRepositoryHandler, repository: 'rails/rails') }
  let(:repository_info) { { 'stargazers_count' => 1, 'forks_count' => 2 } }
  let(:commits) { [{ 'commit' => { 'author' => { 'date' => '2018-01-01' } } }] }

  before do
    allow(GithubRepositoryHandler).to receive(:new).and_return(github_repository_handler)
    allow(github_repository_handler).to receive(:get_repository_info).and_return(true)
    allow(github_repository_handler).to receive(:get_commits).and_return(true)
    allow(github_repository_handler).to receive(:repository_info).and_return(repository_info)
    allow(github_repository_handler).to receive(:commits).and_return(commits)
  end

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

  describe '#update_project_info after_save' do
    let(:repository) { build(:repository, name: 'rails/rails', category: build(:category)) }

    it 'updates project_info' do
      expect(repository.project_info).to be_nil
      repository.save
      expect(repository.project_info).to include({
        'stars_count' => 1,
        'forks_count' => 2
      })
    end

    context 'when repository_info is nil' do
      let(:repository_info) { nil }

      it 'does not update project_info' do
        expect(repository.project_info).to be_nil
        repository.save
        expect(repository.project_info).to be_nil
      end
    end

    context 'when commits is empty' do
      let(:commits) { [] }

      it 'does not update project_info' do
        expect(repository.project_info).to be_nil
        repository.save
        expect(repository.project_info).to be_nil
      end
    end
  end

  describe '.find_by_formatted_name' do
    it 'returns the repository' do
      repository = create(:repository, name: 'OWNER/REPOSITORY')
      expect(Repository.find_by_formatted_name('owner/repository')).to eq(repository)
    end

    it 'returns nil if repository is not found' do
      expect(Repository.find_by_formatted_name('invalid')).to be_nil
    end
  end

  describe '.find_or_initialize_by_formatted_name' do
    it 'returns the repository' do
      repository = create(:repository, name: 'OWNER/REPOSITORY')
      expect(Repository.find_or_initialize_by_formatted_name('owner/repository')).to eq(repository)
    end

    it 'returns a new repository' do
      expect(Repository.find_or_initialize_by_formatted_name('invalid')).to be_a(Repository)
    end

    it 'returns nil if the name is nil' do
      expect(Repository.find_or_initialize_by_formatted_name(nil)).to be_nil
    end
  end
end
