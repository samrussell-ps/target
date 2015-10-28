class DictionaryEntry < ActiveRecord::Base
  has_many :boards
  has_many :submitted_words
end
