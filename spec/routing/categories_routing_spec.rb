require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/technology/category").to route_to(
        {
          "controller"=>"categories",
          "action"=>"show",
          "category_name"=>"category",
          "technology_name"=>"technology"
        }
      )
    end
  end
end