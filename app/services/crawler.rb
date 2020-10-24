require 'net/http'

class Crawler
  SOURCES = ['https://traversemountainpetcare.com/fun-facts-and-information/fun-cat-facts-for-kids/']

  def self.index!
    new.index!
  end

  def index!
    SOURCES.each do |source|
      scan source
    end
  end

  private

  def scan(source)
    response = request(source)
    tokens = Tokenizer.call(response)
    store(tokens, source)
  end

  def request(source)
    response = Faraday.new.get(source)

    response.success? ? response.body : ''
  end

  def store(tokens, source)
    tokens.each do |token|
      coefficient = coefficient(token: token, source: tokens)
      Token.find_or_initialize_by(word: token, source: source).update(coefficient: coefficient)
    end
  end

  def coefficient(token:, source:)
    source.count(token) * Math.log(Token.where(word: token).count.to_f / sources_count.to_f)
  end

  def sources_count
    @sources_count ||= Token.sources_count
  end
end
