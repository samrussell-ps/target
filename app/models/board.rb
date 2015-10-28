class Board < ActiveRecord::Base
  belongs_to :dictionary_entry
  has_many :submitted_word
end
