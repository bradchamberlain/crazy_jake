require 'spec_helper'

describe "surveys/new" do
  let(:customer) { FactoryGirl.create(:customer)}
  before(:each) do
    Customer.destroy_all
    @customer = customer
    assign(:survey, stub_model(Survey,
      :name => "MyText",
      :customer => customer
    ).as_new_record)
  end

  it "renders new survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_surveys_path(@customer), "post" do
      assert_select "input#survey_name[name=?]", "survey[name]"
    end
  end
end
