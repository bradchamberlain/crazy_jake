class CompleteSurvey < ActiveRecord::Base
  belongs_to :survey

  validates :survey_id, presence: true
  validates :ip_address, presence: true
end
