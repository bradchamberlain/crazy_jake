class CreateTrackingTypes < ActiveRecord::Migration
  def change
    create_table :tracking_types do |t|
      t.string :description
      t.integer :days

      t.timestamps
    end
  end
end
