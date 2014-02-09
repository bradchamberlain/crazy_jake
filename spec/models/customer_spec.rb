require 'spec_helper'

describe Customer do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :monthly_cost}
  it { should validate_numericality_of(:monthly_cost).is_greater_than(3) }
end
