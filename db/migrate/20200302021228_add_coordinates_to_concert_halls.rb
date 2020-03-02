class AddCoordinatesToConcertHalls < ActiveRecord::Migration[5.2]
  def change
    add_column :concert_halls, :latitude, :float
    add_column :concert_halls, :longitude, :float
  end
end
