class ReportingFieldsController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_survey
  before_filter :set_reporting_field, only: [:show,:edit, :update, :destroy]

  def index
  end

  def new
    @reporting_field = ReportingField.new
  end

  def edit
  end

  def create
    @reporting_field = ReportingField.new(reporting_field_params)
    @reporting_field.survey = @survey

    respond_to do |format|
      if @reporting_field.save
        format.html { redirect_to customer_survey_reporting_fields_path(@customer,@survey), notice: "#{@reporting_field.field_title} was successfully created." }
        format.json { render action: 'show', status: :created, location: @reporting_field }
      else
        format.html { render action: 'new' }
        format.json { render json: @reporting_field.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reporting_field.update(reporting_field_params)
        format.html { redirect_to customer_survey_reporting_fields_path(@customer,@survey), notice: "#{@reporting_field.field_title} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reporting_field.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reporting_field.destroy
    respond_to do |format|
      format.html { redirect_to customer_survey_reporting_fields_path(@customer,@survey), notice: "#{@reporting_field.field_title} was deleted" }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_reporting_field
    @reporting_field = ReportingField.find(params[:id])
    raise unless @reporting_field.survey == @survey
  end

  def set_survey
    set_customer unless @customer
    @survey = Survey.find(params[:survey_id])
    raise unless @survey.customer == @customer
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reporting_field_params
    params.require(:reporting_field).permit(:field_title, :survey_id, :field_values)
  end

  def set_customer
    @customer = current_user.admin? ? Customer.find(params[:customer_id]) : current_user.customer
  end

end