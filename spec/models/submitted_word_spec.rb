require 'rails_helper'

RSpec.describe SubmittedWord, type: :model do
  let(:board_dictionary_word) { DictionaryWord.order("RANDOM()").first }
  let(:word_shuffle_seed) { 234 }
  let(:board) { Board.create!(dictionary_word: board_dictionary_word, word_shuffle_seed: word_shuffle_seed, centre_letter_offset: 1) }
  let(:submitted_word_dictionary_word) { DictionaryWord.order("RANDOM()").first }

  it 'accepts with a valid board and dictionary_word' do
    expect(SubmittedWord.create(board: board, dictionary_word: submitted_word_dictionary_word)).to be_valid
  end

  it 'does not accept with no board and no dictionary_word' do
    expect(SubmittedWord.create(board: nil, dictionary_word: submitted_word_dictionary_word)).to_not be_valid
  end

  it 'does not accept with a valid board and no dictionary_word' do
    expect(SubmittedWord.create(board: board, dictionary_word: nil)).to_not be_valid
  end

  it 'does not accept with no board and no dictionary_word' do
    expect(SubmittedWord.create(board: nil, dictionary_word: nil)).to_not be_valid
  end
end
