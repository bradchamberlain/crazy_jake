class PaymentsController < ApplicationController
  before_action :set_customer

  # GET /payments
  # GET /payments.json
  def index
  end

  # POST /payments.json
  def create
    # Amount in cents
    @amount = @customer.monthly_cost * 100

    c = Stripe::Customer.create(
      email: current_user.email,
      description: (@customer.name + " made by " + current_user.email),
      card: params[:stripe_card_token]
    )

    charge = Stripe::Charge.create(
        :customer    => c.id,
        :amount      => @amount,
        :description => "#{@customer.name} Survey and Reporting",
        :currency    => 'usd'
    )

    @customer.payment_received = Date.today
    @customer.payment_token = c[:cards][:data][0][:fingerprint]
    @customer.save
    redirect_to paid_customer_payment_path(@customer, 1)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to customer_payments_path
  end

  def paid

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:customer_id])
    end
end
