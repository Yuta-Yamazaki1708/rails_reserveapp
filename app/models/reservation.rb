class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :num_people, presence: true, numericality: true

  validate :not_after_start_at
  validate :not_num_people_minus
  validate :not_start_at_before_today

  def not_after_start_at
    return if end_at.nil? || start_at.nil?
    
    if end_at < start_at
      errors.add(:end_at, "は開始日以降の日付を選択してください")
    end
  end

  def not_num_people_minus
    return if num_people.nil?

    errors.add(:num_people, "は1人以上を入力してください") if num_people < 1
  end

  def not_start_at_before_today
    return if start_at.nil?

    errors.add(:start_at, "は本日以降の日付を入力してください") if start_at < Date.today
  end
end
