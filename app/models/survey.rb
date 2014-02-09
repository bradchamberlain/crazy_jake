class Survey < ActiveRecord::Base
  belongs_to :customer
  belongs_to :tracking_type
  has_many :questions, dependent: :destroy
  has_many :reporting_fields, dependent: :destroy
  has_many :complete_surveys, dependent: :destroy

  validates :name, {presence: true, uniqueness: {scope: :customer_id, allow_blank: false }}
  validates :customer_id, { presence: true }
end
