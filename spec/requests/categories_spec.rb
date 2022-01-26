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
        expect(response).to redirect_to root_path
      end
    end

    context "when technology does not exist" do
      it "renders a not found response" do
        get "/technology/category"
        expect(response).to redirect_to root_path
      end
    end

    context "when a technology or category is upper case" do
      it "renders a successful response" do
        technology = create(:technology, { name: 'ruby' })
        category = create(:category, { name: 'authentication', technology: technology })
        get "/#{technology.name.upcase}/#{category.name.upcase}"
        expect(response).to be_successful
      end
    end
  end
end
