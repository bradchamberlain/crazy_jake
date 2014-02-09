class Customer < ActiveRecord::Base
  validates :name, {uniqueness: true, presence: true}
  validates :monthly_cost, {presence: true, numericality: { greater_than: 3 }  }
  has_many :surveys, dependent: :destroy
  has_many :users, dependent: :destroy

  has_attached_file :logo, styles: { small: "150x150>", icon: "70x70>" }

  def active?
    payment_received ? (Time.now - (1.month + 1.day)) < payment_received : false
  end
end
