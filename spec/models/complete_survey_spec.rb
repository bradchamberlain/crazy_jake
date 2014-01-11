require 'spec_helper'

describe CompleteSurvey do
  it { should validate_presence_of :survey_id }
end
