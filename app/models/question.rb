class QuestionValidator < ActiveModel::Validator
  def validate(record)
    if (
          record.yes_no and (record.rating or record.free_form or record.customized) or
          record.rating and (record.yes_no or record.free_form or record.customized) or
          record.free_form and (record.yes_no or record.rating or record.customized) or
          record.customized and (record.yes_no or record.rating or record.free_form)
      )
      record.errors[:yes_no] << 'Only one question type may be selected per question'
    elsif (!record.yes_no and !record.rating and !record.free_form and !record.customized)
      record.errors[:yes_no] << 'A question type must be selected'
    elsif (record.customized and (!record.custom_values.present? or !record.custom_type))
      record.errors[:customized] << 'You must provide the available values and display type when selecting custom question'
    end
  end
end

class Question < ActiveRecord::Base
  belongs_to :survey

  validates :index, {presence: true, uniqueness: {scope: :survey_id, allow_blank: false },numericality: { greater_than: 0}}
  validates :text, { presence: true }
  validates :survey_id, { presence: true }
  validates_with QuestionValidator

  def custom_values_array
    custom_values ? custom_values.strip.split(/[\r\n]+/) : Array.new
  end

  def self.custom_types
    ["single selection","multiple selections","drop-down(single selection)"]
  end


end
