class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable and :omniauthable :confirmable,
  devise :database_authenticatable, :timeoutable,
          :rememberable, :trackable, :validatable

  belongs_to :customer

  validates_presence_of :customer_id, unless: :admin?
  validates :email, { uniqueness: true}
end
