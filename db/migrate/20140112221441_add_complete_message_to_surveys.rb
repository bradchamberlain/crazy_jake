class AddCompleteMessageToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :complete_message, :text
  end
end
