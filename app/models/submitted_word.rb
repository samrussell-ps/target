class SubmittedWord < ActiveRecord::Base
  belongs_to :board
  belongs_to :dictionary_entry

  validates :dictionary_entry, presence: true
  validates :board, presence: true
end
