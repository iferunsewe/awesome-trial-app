require 'rails_helper'

RSpec.describe "/categories", type: :request do
  describe "GET /show" do
    it "renders a successful response" do
      technology = build(:technology)
      category = create(:category, { name: 'Authentication', technology: technology })
      get "/#{technology.name}/#{category.name}"
      expect(response).to be_successful
    end

    context "when category does not exist" do
      it "renders a not found response" do
        technology = create(:technology)
        get "/#{technology.name}/category"
        expect(response).to be_not_found
      end
    end
  end
end
