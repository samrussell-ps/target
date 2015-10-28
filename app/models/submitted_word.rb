class SubmittedWord < ActiveRecord::Base
  belongs_to :board
  belongs_to :dictionary_entry
end
