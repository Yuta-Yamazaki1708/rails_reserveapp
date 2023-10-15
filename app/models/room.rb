class Room < ApplicationRecord
    has_many :reservations, dependent: :destroy
    has_many :users, through: :reservations
    belongs_to :user
    has_one_attached :image
    

    validates :name, presence: true
    validates :introduction, length: {maximum: 50}
    validates :price, presence: true, numericality: true
    validate :price_plus?

    def price_plus?
        return if price.nil?

        errors.add(:price, "は１円以上にしてください") if price < 1 
    end
end
