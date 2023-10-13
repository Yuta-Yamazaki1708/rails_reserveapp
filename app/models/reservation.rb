class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :num_people, presence: true, numericality: true

  validate :not_after_start_at

  def not_after_start_at
    return if end_at.nil? || start_at.nil?
    
    if end_at < start_at
      errors.add(:end_at, "は開始日以降の日付を選択してください")
    end
  end
end
