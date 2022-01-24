require 'rails_helper'

describe GithubRepositoryHandler do
  let(:github_repository_handler) { GithubRepositoryHandler.new('rails/rails') }
  let(:response) { instance_double(HTTParty::Response, parsed_response: parsed_response, code: code) }

  it 'has the correct API_PATH' do
    expect(GithubRepositoryHandler::API_PATH).to eq('https://api.github.com/repos')
  end

  describe '#get_repository_info' do
    let(:parsed_response) { { 'stargazers_count' => 1, 'forks_count' => 2 } }
    let(:code) { 200 }

    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    context 'when the request is successful' do
      it 'returns true if response is ok and sets the repository_info' do
        expect(github_repository_handler.get_repository_info).to be_truthy
        expect(github_repository_handler.repository_info).to eq(parsed_response)
      end
    end

    context 'when the request is not successful' do
      let(:code) { 404 }
      let(:parsed_response) { { 'message' => 'Not Found' } }

      it 'returns false if response is not ok and does not set the repository_info' do
        expect(github_repository_handler.get_repository_info).to be_falsey
        expect(github_repository_handler.repository_info).to be_nil
      end
    end

    context 'when the request is not successful and the rate limit is hit' do
      let(:response) do
        instance_double(
          HTTParty::Response,
          headers: {
            'x-ratelimit-limit' => ['10'],
            'x-ratelimit-remaining' => ['0'],
            'x-ratelimit-reset' => [Time.now.to_i + 50]
          },
          code: 403
        )
      end
      let(:parsed_response) { { 'message' => 'API rate limit exceeded' } }

      it 'returns false if response is not ok and does not set the repository_info' do
        expect(github_repository_handler.get_repository_info).to be_falsey
        expect(github_repository_handler.repository_info).to be_nil
      end
    end
  end

  describe '#get_commits' do
    let(:parsed_response) { [{ 'commit' => { 'author' => { 'date' => '2018-01-01' } } }] }
    let(:code) { 200 }

    before do
      allow(HTTParty).to receive(:get).and_return(response)
    end

    context 'when the request is successful' do
      it 'returns true if response is ok and sets the commits' do
        expect(github_repository_handler.get_commits).to be_truthy
        expect(github_repository_handler.commits).to eq(parsed_response)
      end
    end

    context 'when the request is not successful' do
      let(:code) { 404 }
      let(:parsed_response) { { 'message' => 'Not Found' } }

      it 'returns false if response is not ok and does not set the commits' do
        expect(github_repository_handler.get_commits).to be_falsey
        expect(github_repository_handler.commits).to be_empty
      end
    end

    context 'when the request is not successful and the rate limit is hit' do
      let(:response) do
        instance_double(
          HTTParty::Response,
          headers: {
            'x-ratelimit-limit' => ['10'],
            'x-ratelimit-remaining' => ['0'],
            'x-ratelimit-reset' => [Time.now.to_i + 50]
          },
          code: 403
        )
      end
      let(:parsed_response) { { 'message' => 'API rate limit exceeded' } }

      it 'returns false if response is not ok and does not set the commits' do
        expect(github_repository_handler.get_commits).to be_falsey
        expect(github_repository_handler.commits).to be_empty
      end
    end
  end
end
