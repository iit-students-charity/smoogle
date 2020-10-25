require 'net/http'

class Crawler
  SOURCES = [
    'https://en.wikipedia.org/wiki/Cat',
    'https://www.polygon.com/2019/7/18/20696129/cats-2019-musical-trailer-explained',
    'https://www.purina.co.uk/cats/behaviour-and-training/understanding-cat-behaviour/fun-facts-about-cats',
    'https://www.purina.com/articles/cat/facts/10-fascinating-facts-about-cats',

    'https://en.wikipedia.org/wiki/Donald_Trump',
    'https://www.whitehouse.gov/people/donald-j-trump/',
    'https://edition.cnn.com/2020/10/24/politics/donald-trump-joe-biden-oil-fracking-election-2020/index.html',
    'https://projects.fivethirtyeight.com/trump-approval-ratings/'
  ]

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

    # take first 1/3 of tokens to speed up indexing
    reduced_tokens = tokens.each_slice((tokens.size / 3.0).round).to_a.first

    store(reduced_tokens, source)
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
    inverse_frequency = Math.log(sources_count.to_f / sources_with(token).to_f)
    source.count(token) * inverse_frequency
  end

  def sources_with(token)
    count = Token.where(word: token).count

    if count.zero?
      1
    else
      count
    end
  end

  def sources_count
    count = Token.sources_count

    if count.zero?
      1
    else
      count
    end
  end
end
