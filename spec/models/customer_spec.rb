require 'spec_helper'

describe Customer do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
end
