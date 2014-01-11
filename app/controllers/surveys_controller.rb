class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_filter :set_customer
  before_filter :survey_bread_crumb, only: [:show, :edit, :update]
  before_filter :surveys_bread_crumb, only: [:index, :new, :create]

  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.where(customer_id: @customer.id).sort_by(&:id)
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
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
        format.html { redirect_to customer_survey_path(@customer,@survey), notice: 'Survey was successfully created.' }
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
        format.html { redirect_to customer_survey_path(@customer,@survey), notice: 'Survey was successfully updated.' }
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
      format.html { redirect_to customer_surveys_path(@customer) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def survey_params
      params.require(:survey).permit(:name, :customer_id)
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def surveys_bread_crumb
      add_breadcrumb 'Customers', customers_path
      add_breadcrumb @customer.name, customer_path(@customer)
      add_breadcrumb 'Surveys', customer_surveys_path(@customer)
    end

    def survey_bread_crumb
      surveys_bread_crumb
      add_breadcrumb @survey.name, customer_survey_path(@customer, @survey)
    end
end
