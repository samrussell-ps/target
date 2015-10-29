class Board < ActiveRecord::Base
  belongs_to :dictionary_entry
  has_many :submitted_word, dependent: :destroy

  validates :dictionary_entry, presence: true
  validates :word_shuffle_seed, numericality: {
    only_integer: true
  }
end
