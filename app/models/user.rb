class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable and :omniauthable :confirmable,
  devise :database_authenticatable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :customer
end
