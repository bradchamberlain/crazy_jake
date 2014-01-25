require 'spec_helper'

describe ReportingField do
  it {should validate_presence_of :survey_id}
  it {should validate_presence_of :field_title}
  it {should validate_uniqueness_of :field_title}
  it {should validate_presence_of :field_values}
end
