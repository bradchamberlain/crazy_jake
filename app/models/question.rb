class QuestionValidator < ActiveModel::Validator
  def validate(record)
    if (
          record.yes_no and (record.rating or record.free_form) or
          record.rating and (record.yes_no or record.free_form) or
          record.free_form and (record.yes_no or record.rating)
      )
      record.errors[:yes_no] << 'Only one question type may be selected per question'
    elsif (!record.yes_no and !record.rating and !record.free_form)
      record.errors[:yes_no] << 'A question type must be selected'
    end
  end
end

class Question < ActiveRecord::Base
  belongs_to :survey

  validates :index, {presence: true, uniqueness: {scope: :survey_id, allow_blank: false },numericality: { greater_than: 0}}
  validates :text, { presence: true }
  validates :survey_id, { presence: true }
  validates_with QuestionValidator
end
