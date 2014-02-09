class TrackingType < ActiveRecord::Base
  validates :description, {presence: true, uniqueness: true}
  validates :days, {presence: true, uniqueness: true}

  has_many :surveys, dependent: :destroy
end
