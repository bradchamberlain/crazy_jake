require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CompleteSurveysController do

  # This should return the minimal set of attributes required to create a valid
  # CompleteSurvey. As you add validations to CompleteSurvey, be sure to
  # adjust the attributes here as well.
  let(:survey) { FactoryGirl.create(:survey) }
  let(:question) { FactoryGirl.build(:question) }
  let(:custom_question) { FactoryGirl.build(:custom_question)}
  let(:valid_attributes) { { "survey_id" => survey.id, "ip_address" => "123.456.789.101" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompleteSurveysController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    Customer.destroy_all
    Survey.destroy_all
  end

  after :each do
    Customer.destroy_all
    Survey.destroy_all
  end

  describe "GET index" do
    it "assigns all complete_surveys as @complete_surveys" do
      c = FactoryGirl.create(:customer)
      survey.customer = c
      survey.save!
      get :index, {"survey_id" => survey.id}, valid_session
      response.should be_success
    end

    it "does not create a new CompleteSurvey" do
      complete_survey = CompleteSurvey.new
      complete_survey.survey = survey
      complete_survey.ip_address = "0.0.0.0"
      complete_survey.save!
      t = TrackingType.new
      t.description = "Desc"
      t.days = 1
      survey.tracking_type = t
      c = FactoryGirl.create(:customer)
      survey.customer = c
      survey.save!
      get :index, {"survey_id" => survey.id}, valid_session
      response.should render_template "cannot_complete"
      complete_survey.destroy
      t.destroy
      c.destroy
      survey.destroy!
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new CompleteSurvey" do
        expect {
          post :create, {:complete_survey => valid_attributes, "survey_id" => survey.id}, valid_session
        }.to change(CompleteSurvey, :count).by(1)
      end

      it "creates a new CompleteSurvey" do
        question = FactoryGirl.build(:question)
        question.survey = survey
        question.save!
        question2 = FactoryGirl.build(:question)
        question2.survey = survey
        question2.index = 2
        question2.save!
        expect {
          post :create, {:complete_survey => valid_attributes, "survey_id" => survey.id, "question_id" => question.id}, valid_session
        }.to change(CompleteSurvey, :count).by(1)
        question.destroy
        question2.destroy
      end

      it "does not create a new CompleteSurvey" do
        question = FactoryGirl.build(:question)
        question.survey = survey
        question.save!
        question2 = FactoryGirl.build(:question)
        question2.survey = survey
        question2.index = 2
        question2.save!
        complete_survey = CompleteSurvey.new
        complete_survey.survey = survey
        complete_survey.ip_address = "123.456.789.101"
        complete_survey.save!
        expect {
          post :create, {:complete_survey => valid_attributes, "survey_id" => survey.id, "question_id" => question.id, "complete_survey_id" => complete_survey.id}, valid_session
        }.to change(CompleteSurvey, :count).by(0)
        question.destroy
        question2.destroy
        complete_survey.destroy
      end

      it "updates the responses for CompleteSurvey" do
        question = FactoryGirl.build(:question)
        question.survey = survey
        question.save!
        question2 = FactoryGirl.build(:question)
        question2.survey = survey
        question2.index = 2
        question2.save!
        complete_survey = CompleteSurvey.new
        complete_survey.survey = survey
        complete_survey.responses = ''
        complete_survey.ip_address = "123.456.789.101"
        complete_survey.save!
        post :create, {:complete_survey => valid_attributes, "survey_id" => survey.id, "question_id" => question.id, "complete_survey_id" => complete_survey.id, "_response" => "s"}, valid_session
        cs = CompleteSurvey.find(complete_survey.id)
        cs.responses["#{question.id}"].should eq "s"
        question.destroy
        question2.destroy
        cs.destroy
      end


      it "updates the responses for CompleteSurvey with a multi response" do
        question = FactoryGirl.build(:custom_question)
        question.survey = survey
        question.save!
        complete_survey = CompleteSurvey.new
        complete_survey.survey = survey
        complete_survey.responses = ''
        complete_survey.ip_address = "123.456.789.101"
        complete_survey.save!
        post :create, {:complete_survey => valid_attributes, "survey_id" => survey.id, "question_id" => question.id, "complete_survey_id" => complete_survey.id, "_response1" => "s"}, valid_session
        cs = CompleteSurvey.find(complete_survey.id)
        cs.responses["#{question.id}"].should eq "[\"s\"]"
        question.destroy
        cs.destroy
      end
    end

  end

end
