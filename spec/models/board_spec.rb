require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'accepts with a valid DictionaryEntry and seed' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
          word_shuffle_seed: 234)).to be_valid
  end

  it 'does not accept with a seed and no DictionaryEntry' do
    expect(Board.create(dictionary_entry: nil,
          word_shuffle_seed: 234)).to_not be_valid
  end

  it 'does not accept with no DictionaryEntry and no seed' do
    expect(Board.create(dictionary_entry: nil, word_shuffle_seed: nil)).to_not be_valid
  end

  it 'destroys submitted_words when the model is destroyed' do
    board = Board.create!(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"), word_shuffle_seed: 234)
    dictionary_entry1 = DictionaryEntry.order("RANDOM()").first
    dictionary_entry2 = DictionaryEntry.order("RANDOM()").first
    submitted_word1 = SubmittedWord.create!(board: board, dictionary_entry: dictionary_entry1)
    submitted_word2 = SubmittedWord.create!(board: board, dictionary_entry: dictionary_entry2)

    expect { board.destroy! }.to change { SubmittedWord.count }.by(-2)
  end
end
