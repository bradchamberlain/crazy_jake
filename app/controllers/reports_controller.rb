class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_filter :build_report

  require 'open-uri'

  # GET /customer/:id/reports
  def index
    keys = Array.new
    @report.complete_surveys.each do |cs|
      cs.custom_values.each do |ck|
        keys << ck
      end if cs.custom_values.present?
    end
    @reporting_fields = keys.uniq
  end

  def reporting_fields
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "survey_report"
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def build_report
    @customer = current_user.admin? ? Customer.find(params[:customer_id]) : current_user.customer
    @survey = Survey.find(params[:survey_id])
    raise unless @survey.customer == @customer
    complete_surveys = Array.new
    if params[:id].nil? or params[:id] == "1"
      complete_surveys = CompleteSurvey.where(survey: @survey).where.not(responses: nil)
      @report = Report.new @survey, complete_surveys
    elsif params[:id] == "2"
      reporting_field = params.select{|k| k.match /^c_/}.to_a[0]
      complete_surveys = CompleteSurvey.where(survey: @survey).where( "custom_values @> hstore(:key, :value)", key: reporting_field[0], value: reporting_field[1]).where.not(responses: nil)
      @report = Report.new @survey, complete_surveys
      @report.subtitle = (reporting_field[0].match /[^c_].*/).to_s + " " + reporting_field[1]
    end
  end


end
