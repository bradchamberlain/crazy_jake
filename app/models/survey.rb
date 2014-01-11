class Survey < ActiveRecord::Base
  belongs_to :customer
  has_many :questions, dependent: :destroy

  validates :name, {presence: true, uniqueness: {scope: :customer_id, allow_blank: false }}
  validates :customer_id, { presence: true }
end
