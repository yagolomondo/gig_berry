class ConcertHall < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_many_attached :photos
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  include PgSearch::Model
  pg_search_scope :search_by_location_and_styles,
    against: [ :location, :styles ],
    using: {
      tsearch: { prefix: true }
    }
end
