class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :down, :up]
  before_filter :set_survey
  before_filter :questions_bread_crumb, only: [:index, :new, :create]
  before_filter :question_bread_crumb, only: [:show, :edit, :update]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.where(survey_id: @survey.id).sort_by(&:index)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.survey = @survey
    @question.index = survey_index

    respond_to do |format|
      if @question.save
        format.html { redirect_to customer_survey_path(@customer, @survey), notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to customer_survey_path(@customer, @survey), notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    index = @question.index
    @question.destroy
    update_indicies @question.index
    respond_to do |format|
      format.html { redirect_to customer_survey_path(@customer, @survey), notice: "Question was deleted" }
      format.json { head :no_content }
    end
  end

  def up
    question = @survey.questions.where(index: @question.index - 1).first
    @question.index = @survey.questions.size + 1
    @question.save!

    question.index = question.index + 1
    question.save!

    @question.index = question.index - 1
    @question.save!

    respond_to do |format|
      format.html {redirect_to customer_survey_path(@customer, @survey), notice: 'Question was successfully moved up.'}
      format.json { head :no_content }
    end
  end

  def down
    question = @survey.questions.where(index: @question.index + 1).first
    @question.index = @survey.questions.size + 1
    @question.save!

    question.index = question.index - 1
    question.save!

    @question.index = question.index + 1
    @question.save!

    respond_to do |format|
      format.html {redirect_to customer_survey_path(@customer, @survey), notice: 'Question was successfully moved down.'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:text, :index, :survey_id, :yes_no, :rating, :free_form)
    end

    def set_survey
      @survey = Survey.find(params[:survey_id])
      @customer = current_user.admin? ? @survey.customer : current_user.customer
      raise unless @survey.customer == @customer
    end

    def survey_index
      Question.where(survey_id: @survey.id).size + 1
    end

  def questions_bread_crumb
    add_breadcrumb "Customers", customers_path if current_user.admin?
    add_breadcrumb @customer.name, customer_path(@customer)
    add_breadcrumb @survey.name, customer_survey_path(@customer, @survey)
  end

  def question_bread_crumb
    questions_bread_crumb
    add_breadcrumb @question.text, edit_customer_survey_question_path(@customer, @survey, @question)
  end

  def update_indicies index
    @survey.questions.each do |question|
      if question.index > index
        question.index = question.index - 1
        question.save!
      end
    end
  end

end
