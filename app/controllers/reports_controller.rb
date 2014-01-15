class ReportsController < ApplicationController
  before_filter :build_reports
  before_filter :bread_crumb

  # GET /customer/:id/reports
  def index
    @complete_surveys = CompleteSurvey.where(survey: @survey).where.not(responses: nil)
    @responses = Hash.new
    @answers = Hash.new
    @survey.questions.each do |question|
      @answers[question.id] = 0
      @responses[question.id] = Hash.new
      if question.yes_no?
        @responses[question.id][:yes] = 0
        @responses[question.id][:no] = 0
        @complete_surveys.each do |c|
          @responses[question.id][:no] = @responses[question.id][:no] + 1 if c.responses[question.id.to_s] == "0"
          @responses[question.id][:yes] = @responses[question.id][:yes] + 1 if c.responses[question.id.to_s] == "1"
          @answers[question.id] = @answers[question.id] + 1 if c.responses[question.id.to_s]
        end
      elsif question.rating?
        @responses[question.id][:extremely_satisfied] = 0
        @responses[question.id][:very_satisfied] = 0
        @responses[question.id][:satisfied] = 0
        @responses[question.id][:unsatisfied] = 0
        @responses[question.id][:very_unsatisfied] = 0
        @responses[question.id][:unknown] = 0
        @complete_surveys.each do |c|
          @responses[question.id][:extremely_satisfied] = @responses[question.id][:extremely_satisfied] + 1 if c.responses[question.id.to_s] == "5"
          @responses[question.id][:very_satisfied] = @responses[question.id][:very_satisfied] + 1 if c.responses[question.id.to_s] == "4"
          @responses[question.id][:satisfied] = @responses[question.id][:satisfied] + 1 if c.responses[question.id.to_s] == "3"
          @responses[question.id][:unsatisfied] = @responses[question.id][:unsatisfied] + 1 if c.responses[question.id.to_s] == "2"
          @responses[question.id][:very_unsatisfied] = @responses[question.id][:very_unsatisfied] + 1 if c.responses[question.id.to_s] == "1"
          @responses[question.id][:unknown] = @responses[question.id][:unknown] + 1 if c.responses[question.id.to_s] == "0"
          @answers[question.id] = @answers[question.id] + 1 if c.responses[question.id.to_s]
        end
      elsif question.free_form?
        @complete_surveys.each_with_index do |c,i|
          @responses[question.id][i] =  [c.created_at.strftime("%b %e, %Y"), c.responses[question.id.to_s]] if c.responses[question.id.to_s].present?
          @answers[question.id] = @answers[question.id] + 1 if c.responses[question.id.to_s].present?
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def build_reports
    @customer = Customer.find(params[:customer_id])
    @survey = Survey.find(params[:survey_id])
  end

  def bread_crumb
    add_breadcrumb @customer.name, customer_path(@customer), class: "bread_crumb"
    add_breadcrumb @survey.name, customer_survey_path(@customer, @survey), class: "bread_crumb"
    add_breadcrumb "Report", customer_survey_reports_path(@customer,@survey), class: "bread_crumb"
  end

end
