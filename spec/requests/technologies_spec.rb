require 'rails_helper'

RSpec.describe "/technologies", type: :request do

  describe "GET /index" do
    it "renders a successful response" do
      create(:technology, { name: 'Ruby' })
      get root_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      technology = create(:technology, { name: 'Ruby' })
      get "/#{technology.name}"
      expect(response).to be_successful
    end

    context "when technology does not exist" do
      it "renders a not found response" do
        get "/technology"
        expect(response).to redirect_to technologies_path
      end
    end
  end
end
