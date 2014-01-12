require 'spec_helper'

describe "surveys/edit" do
  let(:customer) { FactoryGirl.create(:customer)}
  before(:each) do
    Customer.destroy_all
    @customer = customer
    @survey = assign(:survey, stub_model(Survey,
      :name => "MyText",
      :customer => customer
    ))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_survey_path(@customer, @survey), "post" do
      assert_select "input#survey_name[name=?]", "survey[name]"
    end
  end
end
