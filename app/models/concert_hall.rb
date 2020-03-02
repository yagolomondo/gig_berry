class ConcertHall < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :search_by_name_and_styles,
    against: [ :name, :styles ],
    using: {
      tsearch: { prefix: true }
    }
end
