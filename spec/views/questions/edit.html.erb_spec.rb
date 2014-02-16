require 'spec_helper'

describe "questions/edit" do
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

  it "renders the edit question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_survey_question_path(@customer, @survey, @question), "post" do
      assert_select "textarea#question_text[name=?]", "question[text]"
      assert_select "input#question_yes_no_yes_no"
      assert_select "input#question_rating_rating"
      assert_select "input#question_free_form_free_form"
    end
  end
end
