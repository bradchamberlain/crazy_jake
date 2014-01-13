require 'spec_helper'

describe "surveys/show" do
  let(:customer) { FactoryGirl.create(:customer)}
  before(:each) do
    Customer.destroy_all
    @customer = customer
    @survey = assign(:survey, stub_model(Survey,
      :name => "MyText",
      :customer => customer
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/table/)
  end
end
