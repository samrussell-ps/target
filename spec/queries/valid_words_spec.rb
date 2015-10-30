require 'rails_helper'

describe ValidWords do
  let(:dictionary_entry) { DictionaryEntry.find_by_word!("DEVELOPER") }
  let(:params) { { dictionary_entry: dictionary_entry, word_shuffle_seed: 234 } }
  let(:board) { Board.create!(params) }
  subject(:valid_words) { ValidWords.new(board).call }

  it 'returns all the valid words for a board' do
    expect(valid_words).to include(DictionaryEntry.find_by_word!('POLE'))
    expect(valid_words).to include(DictionaryEntry.find_by_word!('ROPED'))
    expect(valid_words).to include(DictionaryEntry.find_by_word!('LORE'))

    expect(valid_words).to_not include(DictionaryEntry.find_by_word!('DONKEY'))
    expect(valid_words).to_not include(DictionaryEntry.find_by_word!('POOL'))
  end
end
