require 'spec_helper'

describe "questions/new" do
  let(:survey) { FactoryGirl.create(:survey)}
  before(:each) do
    @customer = survey.customer
    @survey = survey
    assign(:question, stub_model(Question,
      :text => "MyText",
      :index => 1,
      :survey => survey,
      :yes_no => false,
      :rating => false,
      :free_form => false
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", customer_survey_questions_path(@customer, @survey), "post" do
      assert_select "textarea#question_text[name=?]", "question[text]"
      assert_select "input#question_yes_no[name=?]", "question[yes_no]"
      assert_select "input#question_rating[name=?]", "question[rating]"
      assert_select "input#question_free_form[name=?]", "question[free_form]"
    end
  end
end
