class Customer < ActiveRecord::Base
  validates :name, {uniqueness: true, presence: true}
  has_many :surveys, dependent: :destroy
end
