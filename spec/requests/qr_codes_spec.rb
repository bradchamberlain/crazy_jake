require 'spec_helper'

describe "QrCodes" do
  describe "GET /qr_codes" do
    it "works! (now write some real specs)" do
      get qr_codes_path, {}, {'HTTPS' => 'on'}
      response.status.should be(200)
    end
  end
end
