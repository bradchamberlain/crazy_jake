class AddPaymentTokenToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :payment_token, :string
  end
end
