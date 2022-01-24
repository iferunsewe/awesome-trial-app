require 'rails_helper'

RSpec.describe "/awesome_lists", type: :request do
  let(:valid_attributes) {
    {
      technology: 'Rails',
      category: 'Ruby',
      repository: 'rails/rails'
    }
  }

  let(:invalid_attributes) {
    {
      technology: nil,
      category: nil,
      repository: nil
    }
  }

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
  
  describe "GET /index" do
    it "renders a successful response" do
      create(:awesome_list, valid_attributes)
      get awesome_lists_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      awesome_list = create(:awesome_list, valid_attributes)
      get awesome_list_url(awesome_list)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_awesome_list_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      awesome_list = create(:awesome_list, valid_attributes)
      get edit_awesome_list_url(awesome_list)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new AwesomeList" do
        expect {
          post awesome_lists_url, params: { awesome_list: valid_attributes }
        }.to change(AwesomeList, :count).by(1)
      end

      it "redirects to the created awesome_list" do
        post awesome_lists_url, params: { awesome_list: valid_attributes }
        expect(response).to redirect_to(awesome_list_url(AwesomeList.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new AwesomeList" do
        expect {
          post awesome_lists_url, params: { awesome_list: invalid_attributes }
        }.to change(AwesomeList, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post awesome_lists_url, params: { awesome_list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          technology: 'Rails',
          category: 'Ruby',
          repository: 'rails/rails7',
        }
      }

      it "updates the requested awesome_list" do
        awesome_list = create(:awesome_list, valid_attributes)
        patch awesome_list_url(awesome_list), params: { awesome_list: new_attributes }
        awesome_list.reload
        expect(awesome_list.repository).to eq('rails/rails7')
      end

      it "redirects to the awesome_list" do
        awesome_list = create(:awesome_list, valid_attributes)
        patch awesome_list_url(awesome_list), params: { awesome_list: new_attributes }
        awesome_list.reload
        expect(response).to redirect_to(awesome_list_url(awesome_list))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        awesome_list = create(:awesome_list, valid_attributes)
        patch awesome_list_url(awesome_list), params: { awesome_list: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested awesome_list" do
      awesome_list = create(:awesome_list, valid_attributes)
      expect {
        delete awesome_list_url(awesome_list)
      }.to change(AwesomeList, :count).by(-1)
    end

    it "redirects to the awesome_lists list" do
      awesome_list = create(:awesome_list, valid_attributes)
      delete awesome_list_url(awesome_list)
      expect(response).to redirect_to(awesome_lists_url)
    end
  end
end
