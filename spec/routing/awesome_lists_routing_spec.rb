require "rails_helper"

RSpec.describe AwesomeListsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/awesome_lists").to route_to("awesome_lists#index")
    end

    it "routes to #new" do
      expect(get: "/awesome_lists/new").to route_to("awesome_lists#new")
    end

    it "routes to #show" do
      expect(get: "/awesome_lists/1").to route_to("awesome_lists#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/awesome_lists/1/edit").to route_to("awesome_lists#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/awesome_lists").to route_to("awesome_lists#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/awesome_lists/1").to route_to("awesome_lists#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/awesome_lists/1").to route_to("awesome_lists#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/awesome_lists/1").to route_to("awesome_lists#destroy", id: "1")
    end
  end
end
