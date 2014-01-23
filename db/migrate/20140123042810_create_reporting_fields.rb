class CreateReportingFields < ActiveRecord::Migration
  def change
    create_table :reporting_fields do |t|
      t.string :field_title
      t.text :field_values

      t.timestamps
    end
  end
end
