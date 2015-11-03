require 'rails_helper'

describe ValidWords do
  subject(:valid_words) { ValidWords.new("DEVELOPER").call }

  it 'returns all the valid words that match a word' do
    expect(valid_words).to include(DictionaryEntry.find_by_word!('POLE'))
    expect(valid_words).to include(DictionaryEntry.find_by_word!('ROPED'))
    expect(valid_words).to include(DictionaryEntry.find_by_word!('LORE'))

    expect(valid_words).to_not include(DictionaryEntry.find_by_word!('DONKEY'))
    expect(valid_words).to_not include(DictionaryEntry.find_by_word!('POOL'))
  end
end
