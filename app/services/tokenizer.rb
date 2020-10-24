class Tokenizer
  attr_reader :text, :tokens

  def self.call(text)
    new(text).call
  end

  def initialize(text)
    @text = text
    @tokens = []
  end

  def call
    sanitize
    tokenize
  end

  private

  def sanitize
    @text = ActionController::Base.helpers
      .strip_tags(text)
      .downcase
      .gsub(/[[:punct:]]/, '') || ''
  end

  def tokenize
    @tokens = text.split(' ').map do |word|
      lemma_of word
    end.reject { |word| word.length < 3 }
  end

  def lemma_of(word)
    lemmatizer.lemma(word)
  end

  def lemmatizer
    @lemmatizer ||= Lemmatizer.new
  end
end
