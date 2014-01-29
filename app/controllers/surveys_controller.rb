class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :card]
  before_filter :set_customer
  before_filter :set_admin
  require 'rqrcode'

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.where(customer_id: @customer.id).sort_by(&:id)
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    setup_reporting_fields
    rqrcode
  end

  # GET /surveys/new
  def new
    @survey = Survey.new
  end

  # GET /surveys/1/edit
  def edit
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)
    @survey.customer = @customer

    respond_to do |format|
      if @survey.save
        format.html { redirect_to customer_survey_path(@customer,@survey), notice: "#{@survey.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @survey }
      else
        format.html { render action: 'new' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.html { redirect_to customer_survey_path(@customer,@survey), notice: "#{@survey.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    respond_to do |format|
      format.html { redirect_to customer_surveys_path(@customer), notice: "#{@survey.name} was deleted" }
      format.json { head :no_content }
    end
  end

  def card
    if @customer.active? or current_user.admin?
      rqrcode
      @reporting_fields = params.select{|k,v| k.match /^c_/}
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "survey_cards"
        end
      end
    else
      render :blank_card
    end
  end

  private

    def setup_reporting_fields
      first_array, *rest = build_values_array
      @reporting_fields = first_array.product(*rest) if first_array
    end

    def build_values_array
      array_holder = Array.new
      @survey.reporting_fields.each do |reporting_field,reporting|
        iteration_array = Array.new
        reporting_field.field_values_array.each_with_index {|value,value_index| iteration_array[value_index] = {"c_" + reporting_field.field_title => value} }
        array_holder << iteration_array
      end
      array_holder
    end

    def rqrcode
      @qr = RQRCode::QRCode.new(qr_survey_path,:size => 8)
    end

    def set_survey
      set_customer unless @customer
      @survey = Survey.find(params[:id])
      raise unless @survey.customer == @customer
    end

    def qr_survey_path
      complete_surveys_url({survey_id: @survey.id}.merge(params.select{|k,v| k.match /^c_/}))
    end


  # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :customer_id, :complete_message)
    end

    def set_customer
      @customer = current_user.admin? ? Customer.find(params[:customer_id]) : current_user.customer
    end

end
