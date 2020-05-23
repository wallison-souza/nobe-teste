require "rails_helper"

RSpec.describe AccountMovementsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/account_movements").to route_to("account_movements#index")
    end

    it "routes to #new" do
      expect(get: "/account_movements/new").to route_to("account_movements#new")
    end

    it "routes to #show" do
      expect(get: "/account_movements/1").to route_to("account_movements#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/account_movements/1/edit").to route_to("account_movements#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/account_movements").to route_to("account_movements#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/account_movements/1").to route_to("account_movements#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/account_movements/1").to route_to("account_movements#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/account_movements/1").to route_to("account_movements#destroy", id: "1")
    end
  end
end
