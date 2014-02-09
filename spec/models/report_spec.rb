require 'spec_helper'

describe Report do

  let(:survey) { FactoryGirl.create(:survey) }
  let(:valid_q_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }
  let(:valid_q2_attributes) { { "text" => "MyText2", "survey_id" => survey.id, index: 2, "yes_no" => false, "rating" => true } }

  describe "Creating a report" do
    it "creates a valid report" do
      r = Report.new survey, Array.new
      r.should_not be_nil
    end
  end

  describe "Getting the custom report colors" do
    it "Gets the correct colors" do
      question = Question.create! valid_q_attributes
      question2 = Question.create! valid_q2_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question.id => 1, question2.id => 2}
      cs.ip_address = "123.456.789.101"
      cs.save!
      r = Report.new survey, [cs]
      r.response_colors(question.id).should eq "['#0000FF','#FF00FF']"
      r.response_colors(question2.id).should eq "['#00AA00','#4444FF','#F8F800','#FFA500','#FF0000','#888888']"
    end
  end
end
