require 'spec_helper'

describe "questions/index" do
  let(:survey) { FactoryGirl.create(:survey)}
  before(:each) do
    @customer = survey.customer
    @survey = survey
    assign(:questions, [
      stub_model(Question,
        :text => "MyText",
        :index => 1,
        :survey => survey,
        :yes_no => false,
        :rating => false,
        :free_form => false
      ),
      stub_model(Question,
        :text => "MyText",
        :index => 1,
        :survey => survey,
        :yes_no => false,
        :rating => false,
        :free_form => false
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 6
  end
end
