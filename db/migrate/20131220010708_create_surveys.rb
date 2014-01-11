class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :name
      t.references :customer, index: true

      t.timestamps
    end
  end
end
