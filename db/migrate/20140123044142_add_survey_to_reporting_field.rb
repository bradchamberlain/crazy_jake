class AddSurveyToReportingField < ActiveRecord::Migration
  def change
    add_reference :reporting_fields, :survey, index: true
  end
end
