class AddResponsesToCompleteSurveys < ActiveRecord::Migration
  def change
    execute "create extension hstore"
    add_column :complete_surveys, :responses, :hstore
    add_column :complete_surveys, :custom_values, :hstore
  end
end
