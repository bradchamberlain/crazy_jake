require 'spec_helper'

describe CompleteSurvey do
  it { should validate_presence_of :survey_id }
  it { should validate_presence_of :ip_address }
end
