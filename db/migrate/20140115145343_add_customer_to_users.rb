class AddCustomerToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :customer, index: true
    add_column :users, :admin, :boolean, :default => false
  end

end
