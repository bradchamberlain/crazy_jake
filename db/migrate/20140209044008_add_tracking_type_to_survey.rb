class AddTrackingTypeToSurvey < ActiveRecord::Migration
  def change
    add_reference :surveys, :tracking_type, index: true
  end
end
