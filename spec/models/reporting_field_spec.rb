require 'spec_helper'

describe ReportingField do
  it {should validate_presence_of :survey_id}
  it {should validate_presence_of :field_title}
  it {should validate_uniqueness_of :field_title}
  it {should validate_presence_of :field_values}

  describe "The values Array" do
    it "should get the proper array" do
      rs = ReportingField.new
      rs.field_values_array.size.should eq 0
      rs.field_values = "One\r\nTwo"
      rs.field_values_array.size.should eq 2
      rs.field_values_array[0].should eq "One"
      rs.field_values_array[1].should eq "Two"
    end
  end
end
