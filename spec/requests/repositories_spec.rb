require 'rails_helper'

RSpec.describe "/repositories", type: :request do
  describe "GET /new" do
    it "renders a successful response" do
      get "/repositories/new"
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "when repository is valid" do
      it "creates a new Repository" do
        technology = create(:technology)
        category = create(:category, { name: 'Authentication', technology: technology })
        repository = build(:repository, { name: 'owner/repository', category: category })
        expect {
          post "/repositories", params: { repository: repository.name, category: category.name, technology: technology.name }
        }.to change(Repository, :count).by(1)
      end

      it "redirects to the created repository" do
        technology = create(:technology)
        category = create(:category, { name: 'Authentication', technology: technology })
        repository = build(:repository, { name: 'owner/repository', category: category })
        post "/repositories", params: { repository: repository.name, category: category.name, technology: technology.name }
        expect(response).to redirect_to("/#{technology.name}/#{category.name}")
      end
    end

    context "when repository is invalid" do
      it "renders the new template" do
        post "/repositories", params: { repository: 'owner/repository', category: 'Authentication', technology: nil }
        expect(response).to render_template(:new)
      end
    end
  end
end
