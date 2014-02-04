class PaymentsController < ApplicationController
  before_action :set_customer

  # GET /payments
  # GET /payments.json
  def index
  end

  # POST /payments.json
  def create
    @customer.payment_received = Date.today if params[:stripe_card_token].present?
    @customer.save
    redirect_to customer_path(@customer.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
end
