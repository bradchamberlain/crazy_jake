class AddActiveToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :payment_received, :date
  end
end
