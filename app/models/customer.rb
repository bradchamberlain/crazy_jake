class Customer < ActiveRecord::Base
  validates :name, {uniqueness: true, presence: true}
  has_many :surveys, dependent: :destroy
  has_many :users, dependent: :destroy

  has_attached_file :logo, styles: { small: "150x150>", icon: "70x70>" }
end
