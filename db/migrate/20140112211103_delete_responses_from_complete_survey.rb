class DeleteResponsesFromCompleteSurvey < ActiveRecord::Migration
  def change
    remove_column :complete_surveys, :responses
    remove_column :complete_surveys, :custom_values
  end
end
