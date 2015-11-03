class Board < ActiveRecord::Base
  belongs_to :dictionary_entry
  has_many :submitted_words, dependent: :destroy

  validates :dictionary_entry, presence: true
  validates :word_shuffle_seed, numericality: {
    only_integer: true
  }
  validates :maximum_score, numericality: {
    only_integer: true
  }

  def valid_words
    ValidWords.new(dictionary_entry.word).call
  end
end
