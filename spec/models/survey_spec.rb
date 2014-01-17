require 'spec_helper'

describe Survey do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :customer_id }
  it { should belong_to :customer}
end
