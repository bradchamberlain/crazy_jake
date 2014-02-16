require 'spec_helper'

describe Question do
  it { should validate_uniqueness_of :index }
  it { should validate_presence_of :index}

  it { should validate_numericality_of(:index) }
  it { should validate_presence_of :text }
  it { should validate_presence_of :survey_id }

    context "When trying to save a question" do

      let(:survey) { FactoryGirl.create(:survey) }
      let(:valid_attributes) { { "text" => "MyText", "survey_id" => survey.id, index: 1, "yes_no" => true } }

      it "should not allow the save for free form and yes no" do
        question = Question.create! valid_attributes
        question.free_form = true
        question.yes_no = true
        question.valid?.should be_false
        question.errors[:yes_no][0].should eq "Only one question type may be selected per question"
      end

      it "should not allow the save for free form and rating" do
        question = Question.create! valid_attributes
        question.free_form = true
        question.rating = true
        question.valid?.should be_false
        question.errors[:yes_no][0].should eq "Only one question type may be selected per question"
      end

      it "should not allow the save for rating and yes no" do
        question = Question.create! valid_attributes
        question.rating = true
        question.yes_no = true
        question.valid?.should be_false
        question.errors[:yes_no][0].should eq "Only one question type may be selected per question"
      end

      it "should not allow the save for custom without type or custom values" do
        question = Question.create! valid_attributes
        question.yes_no = false
        question.customized = true
        question.valid?.should be_false
        question.errors[:customized][0].should eq "You must provide the available values and display type when selecting custom question"
      end

      it "should have custom types" do
        Question.custom_types.class.should eq Array
      end

    end
end
