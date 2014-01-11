require "spec_helper"

describe QrCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/qr_codes").should route_to("qr_codes#index")
    end

  end
end
