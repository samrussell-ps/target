require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'accepts with a valid DictionaryEntry and seed and maximum score and centre letter offset' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
          word_shuffle_seed: 234,
          maximum_score: 5,
          centre_letter_offset: 3)).to be_valid
  end

  it 'does not with no DictionaryEntry' do
    expect(Board.create(dictionary_entry: nil,
          word_shuffle_seed: 234,
          maximum_score: 5,
          centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with no seed' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: nil,
            maximum_score: 5,
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with non-numeric seed' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 'pizza',
            maximum_score: 5,
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with no maximum_score' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: nil,
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with non-numeric maximum score' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: 'pizza',
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with no centre letter offset' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: 5,
            centre_letter_offset: nil)).to_not be_valid
  end

  it 'does not accept with bad centre letter offset' do
    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: 5,
            centre_letter_offset: -1)).to_not be_valid

    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: 5,
            centre_letter_offset: 9)).to_not be_valid

    expect(Board.create(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            maximum_score: 5,
            centre_letter_offset: 'pizza')).to_not be_valid
  end

  it 'destroys submitted_words when the model is destroyed' do
    board = Board.create!(dictionary_entry: DictionaryEntry.find_by_word!("DEVELOPER"), word_shuffle_seed: 234, maximum_score: 5, centre_letter_offset: 3)
    dictionary_entry1 = DictionaryEntry.order("RANDOM()").first
    dictionary_entry2 = DictionaryEntry.order("RANDOM()").first
    submitted_word1 = SubmittedWord.create!(board: board, dictionary_entry: dictionary_entry1)
    submitted_word2 = SubmittedWord.create!(board: board, dictionary_entry: dictionary_entry2)

    expect { board.destroy! }.to change { SubmittedWord.count }.by(-2)
  end
end
