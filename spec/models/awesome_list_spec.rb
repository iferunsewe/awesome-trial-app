require 'rails_helper'

RSpec.describe AwesomeList, type: :model do
  let(:awesome_list) { build(:awesome_list) }
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

  it { should validate_presence_of(:technology) }
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:repository) }
  it { should validate_uniqueness_of(:technology).scoped_to(:category, :repository) }
  
  describe '#update_project_info' do
    it 'updates project_info' do
      expect(awesome_list.project_info).to be_nil
      awesome_list.save
      expect(awesome_list.project_info).to include({
        'stars_count' => 1,
        'forks_count' => 2
      })
    end

    context 'when repository_info is nil' do
      let(:repository_info) { nil }

      it 'does not update project_info' do
        expect(awesome_list.project_info).to be_nil
        awesome_list.save
        expect(awesome_list.project_info).to be_nil
      end
    end

    context 'when commits is empty' do
      let(:commits) { [] }

      it 'does not update project_info' do
        expect(awesome_list.project_info).to be_nil
        awesome_list.save
        expect(awesome_list.project_info).to be_nil
      end
    end
  end
end
