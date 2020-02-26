class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :total_price
      t.references :user, foreign_key: true
      t.references :concert_hall, foreign_key: true

      t.timestamps
    end
  end
end
