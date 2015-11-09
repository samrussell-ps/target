require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'accepts with a valid DictionaryWord and seed and centre letter offset' do
    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
          word_shuffle_seed: 234,
          centre_letter_offset: 3)).to be_valid
  end

  it 'does not with no DictionaryWord' do
    expect(Board.create(dictionary_word: nil,
          word_shuffle_seed: 234,
          centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with no seed' do
    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: nil,
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with non-numeric seed' do
    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 'pizza',
            centre_letter_offset: 3)).to_not be_valid
  end

  it 'does not accept with no centre letter offset' do
    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            centre_letter_offset: nil)).to_not be_valid
  end

  it 'does not accept with bad centre letter offset' do
    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            centre_letter_offset: -1)).to_not be_valid

    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            centre_letter_offset: 9)).to_not be_valid

    expect(Board.create(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"),
            word_shuffle_seed: 234,
            centre_letter_offset: 'pizza')).to_not be_valid
  end

  it 'destroys submitted_words when the model is destroyed' do
    board = Board.create!(dictionary_word: DictionaryWord.find_by_word!("DEVELOPER"), word_shuffle_seed: 234, centre_letter_offset: 3)
    dictionary_word1 = DictionaryWord.order("RANDOM()").first
    dictionary_word2 = DictionaryWord.order("RANDOM()").first
    submitted_word1 = SubmittedWord.create!(board: board, dictionary_word: dictionary_word1)
    submitted_word2 = SubmittedWord.create!(board: board, dictionary_word: dictionary_word2)

    expect { board.destroy! }.to change { SubmittedWord.count }.by(-2)
  end
end
