require 'spec_helper'

describe ReportingFieldsController do

  let(:survey) { FactoryGirl.create(:survey)}

  let(:valid_attributes) { { "field_title" => "MyText", "field_values" => "values", "survey_id" => survey.id } }

  let(:valid_session) { {} }

  before :each do
    ReportingField.destroy_all
    user = FactoryGirl.create(:user)
    sign_in user
  end


  describe "GET index" do
    it "assigns all ReportingField as @ReportingField" do
      reporting_field = ReportingField.create! valid_attributes
      get :index, {customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      response.should be_success
    end
  end

  describe "GET new" do
    it "assigns a new reporting field as @reporting field" do
      get :new, {customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      assigns(:reporting_field).should be_a_new(ReportingField)
    end
  end

  describe "GET edit" do
    it "assigns the requested reporting_field as @reporting_field" do
      reporting_field = ReportingField.create! valid_attributes
      get :edit, {customer_id: survey.customer.id,survey_id: survey.id, :id => reporting_field.to_param}, valid_session
      assigns(:reporting_field).should eq(reporting_field)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reporting Field" do
        expect {
          post :create, {customer_id: survey.customer.id, survey_id: survey, :reporting_field => valid_attributes}, valid_session
        }.to change(Survey, :count).by(1)
      end

      it "assigns a newly created reporting field as @reporting_field" do
        post :create, {:reporting_field => valid_attributes, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        assigns(:reporting_field).should be_a(ReportingField)
        assigns(:reporting_field).should be_persisted
      end

      it "redirects to the created reporting view" do
        post :create, {:reporting_field => valid_attributes, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        response.should redirect_to(customer_survey_reporting_fields_path(survey.customer, survey))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reporting field as @reporting_field" do
        ReportingField.any_instance.stub(:save).and_return(false)
        post :create, {:reporting_field => { "name" => "invalid value" }, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        assigns(:reporting_field).should be_a_new(ReportingField)
      end

      it "re-renders the 'new' template" do
        ReportingField.any_instance.stub(:save).and_return(false)
        post :create, {:reporting_field => { "name" => "invalid value" }, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reporting field" do
        reporting_field = ReportingField.create! valid_attributes
        ReportingField.any_instance.should_receive(:update).with({ "field_title" => "MyText" })
        put :update, {:id => reporting_field.to_param, :reporting_field => { "field_title" => "MyText" }, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      end

      it "assigns the requested reporting field as @reporting_field" do
        reporting_field = ReportingField.create! valid_attributes
        put :update, {:id => reporting_field.to_param, :reporting_field => valid_attributes, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        assigns(:reporting_field).should eq(reporting_field)
      end

      it "redirects to the index" do
        reporting_field = ReportingField.create! valid_attributes
        put :update, {:id => reporting_field.to_param, :reporting_field => valid_attributes, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        response.should redirect_to(customer_survey_reporting_fields_path(survey.customer, survey))
      end
    end

    describe "with invalid params" do
      it "assigns the reporting field as @reporting field" do
        reporting_field = ReportingField.create! valid_attributes
        ReportingField.any_instance.stub(:save).and_return(false)
        put :update, {:id => reporting_field.to_param, :reporting_field => { "field_title" => "invalid value" }, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        assigns(:reporting_field).should eq(reporting_field)
      end

      it "re-renders the 'edit' template" do
        reporting_field = ReportingField.create! valid_attributes
        ReportingField.any_instance.stub(:save).and_return(false)
        put :update, {:id => reporting_field.to_param, :reporting_field => { "field_title" => "invalid value" }, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reporting field" do
      reporting_field = ReportingField.create! valid_attributes
      expect {
        delete :destroy, {:id => reporting_field.to_param, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      }.to change(ReportingField, :count).by(-1)
    end

    it "redirects to the reporting fields list" do
      reporting_field = ReportingField.create! valid_attributes
      delete :destroy, {:id => reporting_field.to_param, customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      response.should redirect_to(customer_survey_reporting_fields_path(survey.customer,survey))
    end
  end

end
