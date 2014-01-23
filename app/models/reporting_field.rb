class ReportingField < ActiveRecord::Base
  belongs_to :survey

  validates :field_title, {presence: true, uniqueness: {scope: :survey_id, allow_blank: false }}
  validates :field_values, {presence: true, allow_blank: false }
  validates :survey_id, { presence: true }
end
