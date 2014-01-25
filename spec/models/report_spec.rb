require 'spec_helper'

describe Report do

  let(:survey) { FactoryGirl.create(:survey) }

  describe "Creating a report" do
    it "creates a valid report" do
      r = Report.new survey, Array.new
      r.should_not be_nil
    end
  end
end
