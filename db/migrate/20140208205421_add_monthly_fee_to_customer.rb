class AddMonthlyFeeToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :monthly_cost, :decimal, default: 10.00
  end
end
