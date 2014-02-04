require 'spec_helper'

describe "Payments" do

  let(:customer) { FactoryGirl.create(:customer)}

  before :each do
    Customer.destroy_all
  end

  describe "GET /payments" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get customer_payments_path(customer)
      response.status.should be(200)
    end
  end
end
