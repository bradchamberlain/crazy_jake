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

describe QuestionsController do

  # This should return the minimal set of attributes required to create a valid
  # Question. As you add validations to Question, be sure to
  # adjust the attributes here as well.
  let(:survey) { FactoryGirl.create(:survey) }
  let(:valid_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }
  let(:valid_attributes2) { { "text" => "MyText2", "survey_id" => survey.id, index: 2, "rating" => true } }
  let(:valid_attributes3) { { "text" => "MyText3", "survey_id" => survey.id, index: 3, "free_form" => true } }


  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all questions as @questions" do
      question = Question.create! valid_attributes
      get :index, {customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      assigns(:questions).should eq([question])
    end
  end

  describe "GET show" do
    it "assigns the requested question as @question" do
      question = Question.create! valid_attributes
      get :show, {customer_id: survey.customer.id, survey_id: survey.id, :id => question.to_param}, valid_session
      assigns(:question).should eq(question)
    end
  end

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new, {customer_id: survey.customer.id, survey_id: survey.id}, valid_session
      assigns(:question).should be_a_new(Question)
    end
  end

  describe "GET edit" do
    it "assigns the requested question as @question" do
      question = Question.create! valid_attributes
      get :edit, {customer_id: survey.customer.id, survey_id: survey.id, :id => question.to_param}, valid_session
      assigns(:question).should eq(question)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Question" do
        expect {
          post :create, {customer_id: survey.customer.id, survey_id: survey.id, :question => valid_attributes}, valid_session
        }.to change(Question, :count).by(1)
      end

      it "assigns a newly created question as @question" do
        post :create, {customer_id: survey.customer.id, survey_id: survey.id, :question => valid_attributes}, valid_session
        assigns(:question).should be_a(Question)
        assigns(:question).should be_persisted
      end

      it "redirects to the created question" do
        post :create, {customer_id: survey.customer.id, survey_id: survey.id, :question => valid_attributes}, valid_session
        response.should redirect_to(customer_survey_path(survey.customer, survey))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        post :create, {customer_id: survey.customer.id, survey_id: survey.id,:question => { "text" => "invalid value" }}, valid_session
        assigns(:question).should be_a_new(Question)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        post :create, {customer_id: survey.customer.id, survey_id: survey.id, :question => { "text" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested question" do
        question = Question.create! valid_attributes
        # Assuming there are no other questions in the database, this
        # specifies that the Question created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Question.any_instance.should_receive(:update).with({ "text" => "MyText" })
        put :update, {customer_id: survey.customer.id, survey_id: survey.id,:id => question.to_param, :question => { "text" => "MyText" }}, valid_session
      end

      it "assigns the requested question as @question" do
        question = Question.create! valid_attributes
        put :update, {customer_id: survey.customer.id, survey_id: survey.id,:id => question.to_param, :question => valid_attributes}, valid_session
        assigns(:question).should eq(question)
      end

      it "redirects to the question" do
        question = Question.create! valid_attributes
        put :update, {customer_id: survey.customer.id, survey_id: survey.id,:id => question.to_param, :question => valid_attributes}, valid_session
        response.should redirect_to(customer_survey_path(survey.customer, survey))
      end
    end

    describe "with invalid params" do
      it "assigns the question as @question" do
        question = Question.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        put :update, {customer_id: survey.customer.id, survey_id: survey.id,:id => question.to_param, :question => { "text" => "invalid value" }}, valid_session
        assigns(:question).should eq(question)
      end

      it "re-renders the 'edit' template" do
        question = Question.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Question.any_instance.stub(:save).and_return(false)
        put :update, {customer_id: survey.customer.id, survey_id: survey.id, :id => question.to_param, :question => { "text" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested question" do
      question = Question.create! valid_attributes
      expect {
        delete :destroy, {customer_id: survey.customer.id, survey_id: survey.id, :id => question.to_param}, valid_session
      }.to change(Question, :count).by(-1)
    end

    it "redirects to the questions list" do
      question = Question.create! valid_attributes
      delete :destroy, {customer_id: survey.customer.id, survey_id: survey.id, :id => question.to_param}, valid_session
      response.should redirect_to(customer_survey_path(survey.customer, survey))
    end

    it "updates the indexes of all the questions" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      question3 = Question.create! valid_attributes3
      survey.questions.first.index.should eq 1
      survey.questions.last.index.should eq 3
      delete :destroy, {customer_id: survey.customer.id, survey_id: survey.id, :id => question2.to_param}, valid_session
      survey.questions.size.should eq 2
      survey.questions.first.index.should eq 1
      survey.questions.last.index.should eq 2
      survey.questions.last.text.should eq question3.text
      survey.questions.first.text.should eq question1.text
    end
  end

  describe "MOVE up" do
    it "rearranges the question order" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      survey.questions.where(text: question1.text)[0].index.should eq 1
      survey.questions.where(text: question2.text)[0].index.should eq 2
      get :up, {customer_id: survey.customer.id, survey_id: survey.id, id: question2.to_param}
      survey.questions.where(text: question1.text)[0].index.should eq 2
      survey.questions.where(text: question2.text)[0].index.should eq 1
    end
  end

  describe "MOVE down" do
    it "rearranges the question order" do
      question1 = Question.create! valid_attributes
      question2 = Question.create! valid_attributes2
      survey.questions.where(text: question1.text)[0].index.should eq 1
      survey.questions.where(text: question2.text)[0].index.should eq 2
      get :down, {customer_id: survey.customer.id, survey_id: survey.id, id: question1.to_param}
      survey.questions.where(text: question1.text)[0].index.should eq 2
      survey.questions.where(text: question2.text)[0].index.should eq 1
    end
  end

end
