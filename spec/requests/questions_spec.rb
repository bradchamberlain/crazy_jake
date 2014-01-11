require 'spec_helper'

describe "Questions" do
  let(:survey) { FactoryGirl.create(:survey)}
  describe "GET /questions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get customer_survey_questions_path survey.customer, survey
      response.status.should be(200)
    end
  end
end
