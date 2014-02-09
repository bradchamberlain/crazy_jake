require 'spec_helper'

describe TrackingType do
    it { should validate_uniqueness_of :description }
    it { should validate_presence_of :description }
    it { should validate_uniqueness_of :days }
    it { should validate_presence_of :days}
end
