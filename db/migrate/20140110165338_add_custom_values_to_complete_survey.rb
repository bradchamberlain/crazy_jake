class AddCustomValuesToCompleteSurvey < ActiveRecord::Migration
  def change
    add_column :complete_surveys, :custom_values, :string
  end
end
