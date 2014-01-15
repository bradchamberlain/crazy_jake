require 'spec_helper'

describe ReportsController do
  let(:survey) { FactoryGirl.create(:survey) }
  let(:valid_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }
  let(:valid_attributes2) { { "text" => "MyText2", "survey_id" => survey.id, index: 2, "rating" => true } }
  let(:valid_attributes3) { { "text" => "MyText3", "survey_id" => survey.id, index: 3, "free_form" => true } }

  describe "GET index" do
    it "assigns all questions as @questions" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      question3 = Question.create! valid_attributes3
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1, question2.id => 1, question3.id => "Hi Text"}
      cs.save!
      get :index, {customer_id: survey.customer.id, survey_id: survey.id}, {}
      response.should be_success
    end
  end

end
