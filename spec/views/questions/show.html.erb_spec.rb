require 'spec_helper'

describe "questions/show" do
  let(:survey) { FactoryGirl.create(:survey)}
  before(:each) do
    @customer = survey.customer
    @survey = survey
    @question = assign(:question, stub_model(Question,
      :text => "MyText",
      :index => 1,
      :survey => survey,
      :yes_no => false,
      :rating => false,
      :free_form => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
