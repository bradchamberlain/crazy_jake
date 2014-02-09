class AddIpAddressToCompleteSurveys < ActiveRecord::Migration
  def change
    add_column :complete_surveys, :ip_address, :string
  end
end
