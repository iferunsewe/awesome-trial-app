class Repository < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: [:category_id]
  validate :name_structure

  belongs_to :category
  after_save :update_project_info, if: :saved_change_to_name

  def stars_count
    project_info['stars_count']
  end

  def forks_count
    project_info['forks_count']
  end

  private

  def update_project_info
    github_repository_handler = GithubRepositoryHandler.new(name)
    github_repository_handler.get_repository_info
    github_repository_handler.get_commits
    if github_repository_handler.repository_info.nil? || github_repository_handler.commits.empty?
      errors.add(:base, 'Repository not found')
    else
      self.update_columns(project_info: {
        stars_count: github_repository_handler.repository_info['stargazers_count'],
        forks_count: github_repository_handler.repository_info['forks_count'],
        time_since_last_commit: DateTime.now - DateTime.parse(github_repository_handler.commits.first['commit']['author']['date'])
      })
    end
  end

  def name_structure
    return true if name&.match(/^[a-zA-Z0-9_\-]+\/[a-zA-Z0-9_\-]+$/)
    errors.add(:name, 'should be in format: owner/repository')
    false
  end
end
