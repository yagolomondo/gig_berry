class CreateConcertHalls < ActiveRecord::Migration[5.2]
  def change
    create_table :concert_halls do |t|
      t.string :name
      t.string :location
      t.integer :capacity
      t.string :styles
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
