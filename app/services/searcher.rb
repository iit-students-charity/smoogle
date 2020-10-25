class Searcher < Struct.new(:query)
  def self.call(query)
    new(query).call
  end

  def call
    Tokenizer.call(query).map do |token|
      Token.where(word: token).applicable
    end.flatten.pluck(:source).uniq
  end
end
