class CompleteSurveysController < ApplicationController
  before_filter :set_survey
  before_filter :next_question

  # GET /complete_surveys
  # GET /complete_surveys.json
  def index
  end

  # POST /complete_surveys
  # POST /complete_surveys.json
  def create
    respond_to do |format|
      if @question
        format.html { render action: :index }
      else
        format.html { render action: 'complete' }
      end
    end
  end

  private

    def next_question
      if params[:question_id]
        question = Question.find(params[:question_id])
        save_responses
        @question = @survey.questions.where("index > ? ", question.index).order('index asc').first
      else
        @question = @survey.questions.order('index asc').first
      end
    end

    def set_survey
      @survey = Survey.find(params[:survey_id])
      current_complete_survey
    end

    def current_complete_survey
      if params[:complete_survey_id]
        @complete_survey = CompleteSurvey.find(params[:complete_survey_id])
      else
        @complete_survey = CompleteSurvey.new
        @complete_survey.survey = @survey
        @complete_survey.custom_values = params.select{|k| k.match /^c_/} if params.select{|k| k.match /^c_/}.present?
        @complete_survey.save!
      end
    end

    def save_responses
      if params[:_response]
        response = params[:_response].strip
        response = response.to_i if response.match /\d/
        @complete_survey.responses = Hash.new if @complete_survey.responses.nil?
        @complete_survey.responses = { params[:question_id] =>  response }.merge(@complete_survey.responses)
        @complete_survey.save!
      end
    end
end
