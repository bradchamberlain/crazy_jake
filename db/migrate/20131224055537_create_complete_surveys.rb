class CreateCompleteSurveys < ActiveRecord::Migration
  def change
    create_table :complete_surveys do |t|
      t.references :survey, index: true
      t.text :responses

      t.timestamps
    end
  end
end
