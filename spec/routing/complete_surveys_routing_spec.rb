require "spec_helper"

describe CompleteSurveysController do
  describe "routing" do

    it "routes to #index" do
      get("/complete_surveys").should route_to("complete_surveys#index")
    end

    it "routes to #create" do
      post("/complete_surveys").should route_to("complete_surveys#create")
    end

  end
end
