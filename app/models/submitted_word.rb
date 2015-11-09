class SubmittedWord < ActiveRecord::Base
  belongs_to :board
  belongs_to :dictionary_word

  validates :dictionary_word, presence: true
  validates :board, presence: true
end
