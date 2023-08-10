class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :avatar
  has_many :reservations, dependent: :destroy
  has_many :rooms, through: :reservations
  has_many :rooms, dependent: :destroy
  
end
