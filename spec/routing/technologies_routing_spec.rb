require "rails_helper"

RSpec.describe TechnologiesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("technologies#index")
    end

    it "routes to #show" do
      expect(get: "/technology").to route_to({"controller"=>"technologies", "action"=>"show", "technology_name"=>"technology"})
    end
  end
end
