class GithubRepositoryHandler
  attr_accessor :query, :repository, :response, :repository_info, :commits
  API_PATH = 'https://api.github.com/repos'.freeze

  def initialize(repository)
    @repository = repository
    @response = nil
    @repository_info = nil
    @commits = []
  end

  def get_repository_info
    puts "Getting repository #{repository}...."
    request_repository

    return !handle_hit_rate_limit if response.code == 403 && rate_limit_hit?
    return handle_other_non_ok_responses if response.code != 200
    
    @repository_info = response.parsed_response
    true
  end

  def get_commits
    puts "Getting commits for #{repository}...."
    request_commits

    return !handle_hit_rate_limit if response.code == 403 && rate_limit_hit?
    return handle_other_non_ok_responses if response.code != 200
      
    @commits = response.parsed_response
    true
  end

  private

  def request_repository
    @response = HTTParty.get(
      "#{API_PATH}/#{repository}",
      headers: headers
    )
  end
  
  def request_commits
    @response = HTTParty.get(
      "#{API_PATH}/#{repository}/commits",
      headers: headers
    )
  end

  def headers
    {
      'Accept' => 'application/vnd.github.v3+json'
    }
  end


  def handle_hit_rate_limit
    return false unless rate_limit_hit?

    rate_limit_limit = response.headers['x-ratelimit-limit'][0]
    rate_limit_reset = response.headers['x-ratelimit-reset'][0]
    time_til_limit_reset = rate_limit_reset.to_i - Time.now.to_i
    puts "You are attempting to make more than #{rate_limit_limit} requests in a minute. " \
          "This is not allowed so please wait #{time_til_limit_reset} seconds before making the next request. " \
          "Please find out more information here https://developer.github.com/v3/#rate-limiting"
    true
  end

  def rate_limit_hit?
    rate_limit_remaining = response.headers['x-ratelimit-remaining'][0]
    rate_limit_remaining.to_i.zero?
  end

  def handle_other_non_ok_responses
    puts "Error making a request to github's API: Status: #{response.code}. Message: #{response.parsed_response['message']}"
    false
  end
end
