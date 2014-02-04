class ReportsController < ApplicationController
  before_action :authenticate_user!

  require 'open-uri'

  # GET /customer/:id/reports
  def index
    build_report
    keys = Array.new
    @report.complete_surveys.each do |cs|
      cs.custom_values.each do |ck|
        keys << ck
      end if cs.custom_values.present?
    end
    @reporting_fields = keys.uniq.sort
  end

  def reporting_fields
    format = build_report
    if format == "html"
      render
    elsif format == "pdf"
      render :pdf => "survey_report"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def build_report
    @customer = current_user.admin? ? Customer.find(params[:customer_id]) : current_user.customer
    @survey = Survey.find(params[:survey_id])
    raise unless @survey.customer == @customer
    raise unless @customer.active? or current_user.admin?
    complete_surveys = CompleteSurvey.where(survey: @survey).where.not(responses: nil)
    sub_title = ""
    format = "html"
    if params[:field]
      format = params[:field][:format]
      params[:field].select{ |k, v| k.match /^c_/ and v.present? }.each do |k, v|
        complete_surveys = complete_surveys.where( "custom_values @> hstore(:key, :value)", key: k, value: v)
        sub_title = sub_title  + (k.match /[^c_].*/).to_s + ": " + v + " | "
      end
    end
    @report = Report.new @survey, complete_surveys
    @report.subtitle = sub_title[0..sub_title.length - 4] if sub_title.length > 0
    format
  end

end
