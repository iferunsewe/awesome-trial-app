class AwesomeList < ApplicationRecord
  validates_presence_of :technology, :category, :repository
  validates_uniqueness_of :technology, scope: [:category, :repository]
  validate :repository_structure
  

  after_save :update_project_info

  private

  def update_project_info
    github_repository_handler = GithubRepositoryHandler.new(repository)
    github_repository_handler.get_repository_info
    github_repository_handler.get_commits
    return false if github_repository_handler.repository_info.nil? || github_repository_handler.commits.empty?

    self.update_columns(project_info: {
      stars_count: github_repository_handler.repository_info['stargazers_count'],
      forks_count: github_repository_handler.repository_info['forks_count'],
      time_since_last_commit: DateTime.now - DateTime.parse(github_repository_handler.commits.first['commit']['author']['date'])
    })
  end

  def repository_structure
    repository.match(/^[a-zA-Z0-9-_]+\/[a-zA-Z0-9-_]+$/) ? true : errors.add(:repository, 'is not a valid structure')
  end
end
