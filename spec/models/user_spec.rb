require 'spec_helper'

describe User do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should belong_to :customer }
  it { should validate_presence_of :customer_id}
end
