class Token < ApplicationRecord
  validates_uniqueness_of :word, scope: :source

  validates :word, :source, :coefficient, presence: true

  def self.sources_count
    all.uniq { |token| token.source }.count
  end
end
