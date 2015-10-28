class DictionaryEntry < ActiveRecord::Base
  has_many :boards
  has_many :submitted_words

  validates :word, format: {
    with: /\A[A-Z]+\z/,
      message: "must be an uppercase string"
  }
end
