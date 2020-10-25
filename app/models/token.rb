class Token < ApplicationRecord
  MIN_COEFFICIENT = 5

  validates_uniqueness_of :word, scope: :source

  validates :word, :source, :coefficient, presence: true

  scope :applicable, -> { where('coefficient >= ?', MIN_COEFFICIENT) }

  def self.sources_count
    all.uniq { |token| token.source }.count
  end
end
