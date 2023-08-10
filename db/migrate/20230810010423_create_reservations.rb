class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.integer :user_id, null: false
      t.integer :room_id, null: false
      t.date :start_at, null: false
      t.date :end_at, null: false
      t.integer :num_people, null: false

      t.timestamps
    end
  end
end
