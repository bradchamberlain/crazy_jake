require 'spec_helper'

describe ReportsController do
  let(:survey) { FactoryGirl.create(:survey) }
  let(:customer) { FactoryGirl.create(:customer)}
  let(:valid_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }
  let(:valid_attributes2) { { "text" => "MyText2", "survey_id" => survey.id, index: 2, "rating" => true } }
  let(:valid_attributes3) { { "text" => "MyText3", "survey_id" => survey.id, index: 3, "free_form" => true } }

  before :each do
    Survey.destroy_all
    Customer.destroy_all
    survey.customer = customer
    survey.save
    user = FactoryGirl.create(:user)
    sign_in user
  end

  after :each do
    Survey.destroy_all
    Customer.destroy_all
    Question.destroy_all
  end

  describe "GET index" do
    it "assigns all questions as @questions" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      question3 = Question.create! valid_attributes3
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1, question2.id => 1, question3.id => "Hi Text"}
      cs.custom_values = {"c_Id" => "abc"}
      cs.ip_address = "123.456.789.101"
      cs.save!
      get :index, {customer_id: survey.customer.id, survey_id: survey.id}, {}
      response.should be_success
    end
  end

  describe "GET pdf" do
    it "gets PDF" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      question3 = Question.create! valid_attributes3
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1, question2.id => 1, question3.id => "Hi Text"}
      cs.custom_values = {"c_Id" => "abc"}
      cs.ip_address = "123.456.789.101"
      cs.save!
      get :reporting_fields, {customer_id: survey.customer.id, survey_id: survey.id, id: 1,  format: :pdf}, {}
      response.should be_success
    end

    it "doesn't get PDF" do
      ruser = FactoryGirl.build(:reg_user)
      c = FactoryGirl.create(:non_active_customer)
      ruser.customer = c
      ruser.save!
      sign_in ruser
      survey.customer = c
      survey.save!
      question1 = Question.create! valid_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1}
      cs.ip_address = "123.456.789.101"
      cs.save!
      expect{
        get :reporting_fields, {customer_id: survey.customer.id, survey_id: survey.id, id: 1,  format: :pdf}, {}
      }.to raise_exception
      ruser.destroy
      survey.destroy
      c.destroy
    end

    it "gets the PDF for admin" do
      c = FactoryGirl.create(:non_active_customer)
      survey.customer = c
      survey.save!
      question1 = Question.create! valid_attributes
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1}
      cs.ip_address = "123.456.789.101"
      cs.save!
      get :reporting_fields, {customer_id: survey.customer.id, survey_id: survey.id, id: 1,  format: :pdf}, {}
      response.should be_success
    end

    it "gets PDF" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      question3 = Question.create! valid_attributes3
      cs = CompleteSurvey.new
      cs.survey = survey
      cs.responses = {question1.id => 1, question2.id => 1, question3.id => "Hi Text"}
      cs.custom_values = {"c_Id" => "abc"}
      cs.ip_address = "123.456.789.101"
      cs.save!
      get :reporting_fields, {customer_id: survey.customer.id, survey_id: survey.id, id: 2,  "field" => { "c_Id" => "abc", "format" => "pdf"}}, {}
      response.should be_success
    end
  end
end
