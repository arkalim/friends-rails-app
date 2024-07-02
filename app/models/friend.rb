class Friend < ApplicationRecord
  belongs_to :user

  FILTER_PARAMS = %i[search sort_by sort_direction].freeze

  scope :search, lambda { |search_term|
    where('LOWER(name) LIKE :search OR LOWER(email) LIKE :search OR LOWER(phone) LIKE :search', search: "%#{search_term&.downcase}%")
  }

  def self.filter(filters)
    Friend.search(filters['search']).order("#{filters['sort_by']} #{filters['sort_direction']}")
  end
end
