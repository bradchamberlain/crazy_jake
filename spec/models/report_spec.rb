require 'spec_helper'

describe Report do

  let(:survey) { FactoryGirl.create(:survey) }
  let(:valid_q_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }
  let(:valid_q2_attributes) { { "text" => "MyText2", "survey_id" => survey.id, index: 2, "yes_no" => false, "rating" => true } }
  let(:valid_q3_attributes) { { "text" => "MyText3", "survey_id" => survey.id, index: 3, "yes_no" => false, "customized" => true, "custom_values" => "hi", "custom_type" => 0 }}

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

    it "Gets the correct colors" do
      question = Question.create! valid_q3_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question.id => 1}
      cs.ip_address = "123.456.789.101"
      cs.save!
      r = Report.new survey, [cs]
      r.response_colors(question.id).should eq "['#836fff','#0000ff','#00bfff','#00ffff','#c1ffc1','#00ff7f','#fff68f','#ffff00','#ffb90f','#ff6a6a','#ff7f24','#ff4040','#ff7f00','#ff4500','#cd0000','#ee1289','#ff3e96','#8b4789','#9b30ff','#ffe1ff']"
    end

    it "Gets the correct highest hit " do
      q1 = Question.create! valid_q_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {q1.id => 1 }
      cs.ip_address = "123.456.789.101"
      cs.save!
      cs2 = CompleteSurvey.new
      cs2.survey = survey
      cs2.responses = {q1.id => 0 }
      cs2.ip_address = "123.456.789.102"
      cs2.save!
      cs3 = CompleteSurvey.new
      cs3.survey = survey
      cs3.responses = {q1.id => 1 }
      cs3.ip_address = "123.456.789.103"
      cs3.save!
      r = Report.new survey, [cs,cs2,cs3]
      r.question_highest_hits(q1.id).should eq :yes
    end

    it "Processes Custom questions for single value" do
      q1 = Question.create! valid_q3_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {q1.id.to_s => 1.to_s }
      cs.ip_address = "123.456.789.101"
      cs.save!
      r = Report.new survey, [cs]
      r.should_not be_nil
    end

    it "Processes Custom questions for multiple values" do
      q1 = Question.create! valid_q3_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {q1.id.to_s => "[\"1\",\"2\"]" }
      cs.ip_address = "123.456.789.101"
      cs.save!
      r = Report.new survey, [cs]
      r.should_not be_nil
    end
  end
end
