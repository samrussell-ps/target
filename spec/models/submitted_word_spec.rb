require 'rails_helper'

RSpec.describe SubmittedWord, type: :model do
  let(:board_dictionary_entry) { DictionaryEntry.order("RANDOM()").first }
  let(:word_shuffle_seed) { 234 }
  let(:board) { Board.create!(dictionary_entry: board_dictionary_entry, word_shuffle_seed: word_shuffle_seed, maximum_score: 1) }
  let(:submitted_word_dictionary_entry) { DictionaryEntry.order("RANDOM()").first }

  it 'accepts with a valid board and dictionary_entry' do
    expect(SubmittedWord.create(board: board, dictionary_entry: submitted_word_dictionary_entry)).to be_valid
  end

  it 'does not accept with no board and no dictionary_entry' do
    expect(SubmittedWord.create(board: nil, dictionary_entry: submitted_word_dictionary_entry)).to_not be_valid
  end

  it 'does not accept with a valid board and no dictionary_entry' do
    expect(SubmittedWord.create(board: board, dictionary_entry: nil)).to_not be_valid
  end

  it 'does not accept with no board and no dictionary_entry' do
    expect(SubmittedWord.create(board: nil, dictionary_entry: nil)).to_not be_valid
  end
end
