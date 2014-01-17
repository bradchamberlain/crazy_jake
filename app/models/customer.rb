class Customer < ActiveRecord::Base
  validates :name, {uniqueness: true, presence: true}
  has_many :surveys, dependent: :destroy
  has_many :users, dependent: :destroy
end
