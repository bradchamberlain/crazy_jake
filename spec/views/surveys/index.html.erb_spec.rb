require 'spec_helper'

describe "surveys/index" do
  let(:customer) { FactoryGirl.create(:customer)}
  before(:each) do
    Customer.destroy_all
    @customer = customer
    assign(:surveys, [
      stub_model(Survey,
        :name => "MyText",
        :customer => customer
      ),
      stub_model(Survey,
        :name => "MyText",
        :customer => customer
      )
    ])
  end

  it "renders a list of surveys" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
