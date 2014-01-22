class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_filter :customers_bread_crumb, only: [:index, :new, :create]
  before_filter :customer_bread_crumb, only: [:show, :edit, :update]

  # GET /customers
  # GET /customers.json
  def index
    if current_user.admin?
      @customers = Customer.all
    else
      redirect_to customer_path(current_user.customer)
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: "#{@customer.name} was successfully created." }
        format.json { render action: 'show', status: :created, location: @customer }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: "#{@customer.name} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: "#{@customer.name} was deleted."}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = current_user.admin? ? Customer.find(params[:id]) : current_user.customer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:name, :logo)
    end

    def customer_bread_crumb
      customers_bread_crumb
      add_breadcrumb @customer.name, customer_path(@customer), class: "bread_crumb"
    end

    def customers_bread_crumb
      if current_user.admin?
        add_breadcrumb "Customers", customers_path, class: "bread_crumb"
      end
    end
end
