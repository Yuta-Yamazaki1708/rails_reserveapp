class Room < ApplicationRecord
    has_many :reservations, dependent: :destroy
    has_many :users, through: :reservations
    belongs_to :user
    has_one_attached :image
    
end
