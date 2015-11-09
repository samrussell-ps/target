class Board < ActiveRecord::Base
  belongs_to :dictionary_word
  has_many :submitted_words, dependent: :destroy

  validates :dictionary_word, presence: true
  validates :word_shuffle_seed, numericality: {
    only_integer: true
  }
  validates :centre_letter_offset, inclusion: {
    in: (0...9)
  }
end
