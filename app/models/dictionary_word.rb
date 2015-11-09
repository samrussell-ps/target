class DictionaryWord< ActiveRecord::Base
  has_many :boards
  has_many :submitted_words

  validates :word, format: {
    with: /\A[A-Z]+\z/,
      message: "must be an uppercase string"
  }

  def self.seed_word
    where("length(word) = 9").order("RANDOM()").first
  end
end
